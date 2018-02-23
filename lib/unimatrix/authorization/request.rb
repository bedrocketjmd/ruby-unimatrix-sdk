require 'net/http'
require 'addressable/uri'

module Unimatrix::Authorization
  class Request < Unimatrix::Request

    def initialize( default_parameters = {} )
      uri   = URI( Unimatrix.configuration.authorization_url )
      @http = Net::HTTP.new( uri.host, uri.port )

      @http.use_ssl = ( uri.scheme == 'https' )
      @http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      @default_parameters = default_parameters.stringify_keys
    end

    def get( path, parameters = {} )
      response = nil

      begin
        response = Response.new(
          @http.get( compose_request_path( path, parameters ) )
        )
      rescue Timeout::Error
        response = nil
      end

      response
    end

    def post( path, parameters = {}, body = {} )
      response = nil

      begin
        request = Net::HTTP::Post.new(
          compose_request_path( path, parameters ),
          { 'Content-Type' =>'application/json' }
        )
        request.body = body.to_json

        response = Response.new( @http.request( request ) )
      rescue Timeout::Error
        response = nil
      end

      response
    end

  end
end