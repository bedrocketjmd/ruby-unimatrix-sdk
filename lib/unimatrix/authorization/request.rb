require 'net/http'
require 'addressable/uri'
require 'pry'

module Unimatrix::Authorization
  class Request < Unimatrix::Request

    def initialize( default_parameters = {} )
      uri   = URI( Unimatrix.configuration.authorization_url )
      @http = Net::HTTP.new( uri.host, uri.port )
      
      timeout_limit = ( ENV[ 'TIMEOUT_LIMIT' ] || 60 ).to_i
      
      @http.open_timeout = timeout_limit
      @http.read_timeout = timeout_limit

      @http.use_ssl = ( uri.scheme == 'https' )
      @http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      @default_parameters = default_parameters.stringify_keys
    end

    def get( path, parameters = {} )
      attempt_request do
        Response.new(
          @http.get( compose_request_path( path, parameters ) ),
          path
        )
      end
    end

    def post( path, parameters = {}, body = {} )
      attempt_request do
        request = Net::HTTP::Post.new(
          compose_request_path( path, parameters ),
          { 'Content-Type' =>'application/json' }
        )
        request.body = body.to_json

        Response.new( @http.request( request ), path )
      end
    end

  end
end