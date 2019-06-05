require 'her'
require 'faraday'
require 'faraday_middleware'
require "facet5/version"

module Facet5
  class << self
    attr_accessor :host

    def api
      @api ||= Her::API.new  
      @api.setup url: "https://www.facet5global.net/apiv2/" do |c|
        # Request
        c.use FaradayMiddleware::EncodeJson
        c.use Her::Middleware::AcceptJSON
        c.use Her::Middleware::FirstLevelParseJSON

        c.adapter Faraday.default_adapter
      end  
    end

    require 'facet5/definitions'
    require 'facet5/project'
    require 'facet5/participant'
  end

  class Error < StandardError; end
end
