require 'rest-client'
require 'oj'
require 'retryable'

module SummerProject
  class Base

    def self.find(id, params = {})
      request(:get, params, path_with_id(id))
    end

    def self.get(params = {})
      request(:get, params)
    end

    def self.post(params = {})
      request(:post, params)
    end

    def self.put(id, params = {})
      request(:put, params, path_with_id(id))
    end

    def self.delete(id)
      request(:delete, {}, path_with_id(id))
    end


    def self.request(method, params, path = nil)
      raise 'You need to configure Summer Project with your access_token.' unless SummerProject.access_token

      path ||= default_path
      url = SummerProject.base_url
      url += '/' unless url.last == '/'
      url += path
      begin
        case method
        when :post
          RestClient.post(url, params, authorization: "Bearer #{SummerProject.access_token}", :timeout => -1) { |response, request, result, &block|
            handle_response(response, request, result)
          }
        when :put
          RestClient.put(url, params, authorization: "Bearer #{SummerProject.access_token}", :timeout => -1) { |response, request, result, &block|
            handle_response(response, request, result)
          }
        else
          RestClient::Request.execute(:method => method, :url => url, :headers => {params: params, authorization: "Bearer #{SummerProject.access_token}"}, :timeout => -1) { |response, request, result, &block|
            handle_response(response, request, result)
          }
        end
      rescue
        raise "SP Client: An error occured while requesting #{url}."
      end
    end

    def self.handle_response(response, request, result)
      case response.code
      when 200..299
        Oj.load(response)
      when 400
        raise RestClient::BadRequest, response
      when 500
        raise RestClient::InternalServerError, response
      else
        puts response.inspect
        puts request.inspect
        raise result.inspect
      end
    end

    def self.default_path
      to_s.split('::').last.underscore.pluralize
    end

    def self.path_with_id(id)
      "#{default_path}/#{id}"
    end

  end
end