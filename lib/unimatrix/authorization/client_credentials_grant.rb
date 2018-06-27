require 'net/http'
require 'json'

module Unimatrix::Authorization
  class ClientCredentialsGrant

    def initialize( args )
      @client_id = args[ :client_id ]
      @client_secret = args[ :client_secret ]
    end

    def request_token( options={} )
      uri      = URI.parse( "#{ Unimatrix.configuration.authorization_url }/token" )
      params   = { "grant_type" => "client_credentials" }
      http     = Net::HTTP.new( uri.host, uri.port )
      request  = Net::HTTP::Post.new( uri.request_uri )

      http.use_ssl = true if uri.scheme == 'https'

      request.basic_auth( @client_id, @client_secret )
      request.set_form_data( params )

      begin
        response = http.request( request )

        if response.code == '200'
          body = JSON.parse( response.body )
          body = body[ 'token' ] if body[ 'token' ].present?

          if options[ :with_expiry ]
            {
              access_token: ( body[ 'access_token' ] rescue nil ),
              expires_in: ( body[ 'expires_in' ] rescue nil )
            }
          else
            body[ 'access_token' ] rescue nil
          end
        else
          puts "ERROR: #{ response.body }"
        end
      rescue => e
        puts "REQUEST FAILED: #{ e }"
      end
    end
  end
end
