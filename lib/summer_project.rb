require 'active_support/core_ext/string/inflections'
require 'summer_project/base'

Dir[File.dirname(__FILE__) + '/summer_project/*.rb'].each do |file|
  require file
end

module SummerProject
  class << self
    attr_accessor :base_url, :access_token

    def configure
      yield self
    end

    def base_url
      @base_url ||= "https://smapp.cru.org/api/v1"
    end

  end
end

