module Concerns
  module SplunkService 
    include 
    SplunkService = Splunk::connect(
      :username => Rails.application.secrets.splunk_username, 
      :password => Rails.application.secrets.splunk_password, 
      host: "<INDEXER>", 
      namespace: Splunk::AppNamespace.new("usergroup_splunk_app")
    )

    SplunkReceiverService = Splunk::connect(
      :username => Rails.application.secrets.splunk_username, 
      :password => Rails.application.secrets.splunk_password, 
      host: "<INDEXER>"
    ) 
    CollectionResource = ["storage", "collections", "data"]

    UserGroupSplunkCollection = Splunk::Collection.new(SplunkService, CollectionResource + ["usergroupcollection"])
    JobRoleSplunkCollection   = Splunk::Collection.new(SplunkService, CollectionResource + ["jobrolecollection"])
    ProductSplunkCollection   = Splunk::Collection.new(SplunkService, CollectionResource + ["productcollection"])
    UseCaseSplunkCollection   = Splunk::Collection.new(SplunkService, CollectionResource + ["usecasecollection"])
  end
end