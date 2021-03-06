require 'net/http'
require 'addressable/uri'

module Unimatrix

  class Request

    def initialize( default_parameters = {} )
      uri   = URI( Unimatrix.configuration.url )
      @http = Net::HTTP.new( uri.host, uri.port )
      
      timeout_limit = ( ENV[ 'TIMEOUT_LIMIT' ] || 60 ).to_i
      
      @http.open_timeout = timeout_limit
      @http.read_timeout = timeout_limit

      @http.use_ssl = ( uri.scheme == 'https' )
      @http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      @default_parameters = default_parameters.stringify_keys
    end

    def destroy( path, parameters = {} )
      attempt_request do
        request = Net::HTTP::Delete.new(
          compose_request_path( path, parameters ),
          { 'Content-Type' =>'application/json' }
        )

        Response.new( @http.request( request ) )
      end
    end

    def get( path, parameters = {} )
      attempt_request do
        Response.new(
          @http.get( compose_request_path( path, parameters ) )
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

        Response.new( @http.request( request ) )
      end
    end

    protected; def attempt_request
      response = nil
      retry_codes = [ '500', '502', '503', '504' ]

      3.times do
        response =
          begin
            yield
          rescue Timeout::Error => error
            log_error( error.inspect )
            
            error
          end

        unless response.nil? || 
               ( response.is_a?( Response ) && retry_codes.include?( response.code ) ) || 
               response.is_a?( Timeout::Error )
               
          break
        end
      end
      
      if response.is_a?( Timeout::Error )
        response = Unimatrix::TimeoutError.new(
          message: response.message
        )
      end

      response
    end

    protected; def compose_request_path( path, parameters = {} )
      parameters        = @default_parameters.merge( parameters.stringify_keys )
      addressable       = Addressable::URI.new

      addressable.path  = path
      addressable.query = parameters.to_param unless parameters.blank?

      addressable.to_s
    end
    
    protected; def log_error( message )
      if defined?( logger.error )
        logger.error( message )
      else
        puts "Error: #{ message }"
      end
    end

  end

end
