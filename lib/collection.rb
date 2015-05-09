module Splunk
  class Collection
    def get(name, namespace=nil)
      request_args = {:resource => @resource + [name]}
      if !namespace.nil?
        request_args[:namespace] = namespace
      end

      begin
        response = @service.request(request_args)
      rescue SplunkHTTPError => err
        if err.code == 404
          return nil
        else
          raise err
        end
      end

      JSON.parse(response)
    end
  end
end