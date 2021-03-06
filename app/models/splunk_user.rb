class SplunkUser < ActiveRecord::Base
  include Concerns::SplunkUserCollections

  attr_accessor :name, :email, :role, :splunk_products, :splunk_use_cases, :notes, :city, :event_id

  validates_presence_of :name, :email, :city
  validates_format_of :email, with: /\A.+@.+\z/, message: "must be a valid email"
  validates_presence_of :role, message: "required"
  validates_presence_of :splunk_products, :splunk_use_cases, message: "at least one item is required"


  def get_user_group(code)
    collection = splunk_get(UserGroupSplunkCollection)
    if collection 
      collection.keep_if {|el| el["addUserGroupCode"].to_s.downcase == code.downcase}
      collection.first
    end
  end

  def job_roles
    get_collection(JobRoleSplunkCollection, "addJobRole")
  end

  def products
    get_collection(ProductSplunkCollection, "addProduct")
  end

  def use_cases
    get_collection(UseCaseSplunkCollection, "addUseCase")
  end

  def splunk_save
    request_args = {
      resource: ["receivers", "simple"], method: :POST, 
      query: {source: 'usergroupapp', index: "splunkusergroups", "sourcetype" => "json"},
      body: to_json
    }

    begin
      response = SplunkReceiverService.request(request_args)
    rescue Splunk::SplunkHTTPError => err
      if err.code == 404
        return nil
      else
        raise err
      end
    end
    true
  end

  def to_json
    { notes: notes, 
      name: name, 
      email: email, 
      role: role, 
      products: splunk_products.join(","), 
      use_cases: splunk_use_cases.join(","), 
      group_city: city, 
      event_id: event_id
    }.to_json
  end


  def invite_to_slack(ip: nil)
    params = {email: email, channels: Figaro.env.slack_channels, first_name: name, token: Rails.application.secrets.slack_api_key, set_active: true, '_attempts' => 1, host: ip}

    url = "https://#{Figaro.env.slack_team}/api/users.admin.invite?t=#{Time.now.to_i}"

    x = Net::HTTP.post_form(URI.parse(url), params)
    x.body
  end

  private

    def splunk_get(collection, id: nil)
      service = collection.service

      resource = collection.resource 
      resource = resource + [id] if id

      request_args = {:resource => resource}

      begin
        response = service.request(request_args)
      rescue Splunk::SplunkHTTPError => err
        if err.code == 404
          return nil
        else
          raise err
        end
      end

      JSON.parse(response.body)
    end

    def get_collection(collection, method)
      result = []
      collection = splunk_get(collection)
      collection.each do |el|
        result << {key: el["_key"], name: el[method]}
      end
      result 
    end

end
