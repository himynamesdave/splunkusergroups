# Check config/application.yml and config/secrets.yml files to set password/username/host etc.
module Concerns
  module SplunkService 
    include 
    SplunkService = Splunk::connect(
      :username => Rails.application.secrets.splunk_username, 
      :password => Rails.application.secrets.splunk_password, 
      host: Figaro.env.splunk_host, 
      namespace: Splunk::AppNamespace.new(Figaro.env.usergroup_app_name)
    )

    SplunkReceiverService = Splunk::connect(
      :username => Rails.application.secrets.splunk_username, 
      :password => Rails.application.secrets.splunk_password, 
      host: Figaro.env.splunk_host
    ) 
    CollectionResource = ["storage", "collections", "data"]

    UserGroupSplunkCollection = Splunk::Collection.new(SplunkService, CollectionResource + [Figaro.env.usergroup_collection])
    JobRoleSplunkCollection   = Splunk::Collection.new(SplunkService, CollectionResource + [Figaro.env.job_role_collection])
    ProductSplunkCollection   = Splunk::Collection.new(SplunkService, CollectionResource + [Figaro.env.product_collection])
    UseCaseSplunkCollection   = Splunk::Collection.new(SplunkService, CollectionResource + [Figaro.env.use_case_collection])
  end
end