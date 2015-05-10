class StatsController < ApplicationController
  # Used to select corresponding field from the search result
  STATS_RESULT_MAP = {"cities" => "group_city", "events" => "event_id", "checkins" => "sum(checkins)"}

  def index
    @email = params[:email]
    if @email.blank?
      return redirect_to root_path, notice: "Please enter your email."
    end
    %W{checkins events cities}.each do |var|
      query = send("#{var}_query")
      search = JSON.parse(SplunkService.jobs.create_oneshot(query, output_mode: :json))

      key = STATS_RESULT_MAP[var]
      key = var unless key

      result = search["results"].pluck(key)
      instance_variable_set("@#{var}", result)
    end

    @checkins = (@checkins.first || 0)
  end

  private 
    def checkins_query
      "search index=splunkusergroups email=#{@email} | bin _time span=1mon | stats dc(email) AS checkins by event_id | stats sum(checkins)"
    end

    def events_query 
      "search index=splunkusergroups email=#{@email} | stats dc(event_id) AS checkins by event_id"
    end

    def cities_query
      "search index=splunkusergroups email=#{@email} | stats dc(group_city) AS checkins by group_city"
    end
end
