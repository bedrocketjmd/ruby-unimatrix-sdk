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

  end
end