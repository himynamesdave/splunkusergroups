# SplunkService and SplunkRecieverService are defined in initializers/splunk_service.rb
module Concerns
  module SplunkUserCollections
    include 
    CollectionResource = ["storage", "collections", "data"]

    UserGroupSplunkCollection = Splunk::Collection.new(SplunkService, CollectionResource + [Figaro.env.usergroup_collection])
    JobRoleSplunkCollection   = Splunk::Collection.new(SplunkService, CollectionResource + [Figaro.env.job_role_collection])
    ProductSplunkCollection   = Splunk::Collection.new(SplunkService, CollectionResource + [Figaro.env.product_collection])
    UseCaseSplunkCollection   = Splunk::Collection.new(SplunkService, CollectionResource + [Figaro.env.use_case_collection])
  end
end