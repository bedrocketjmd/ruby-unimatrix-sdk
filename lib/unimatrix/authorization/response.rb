module Unimatrix::Authorization

  class Response < Unimatrix::Response

    attr_reader :code
    attr_reader :body
    attr_reader :resources

    def initialize( http_response, path = "" )
      @request_path   = path
      @success        = http_response.is_a?( Net::HTTPOK )
      @code           = http_response.code
      @resources      = []
      @body           = decode_response_body( http_response )

      if ( @body && @body.respond_to?( :keys ) )
        Parser.new( @body, @request_path ) do | parser |
          @resources = parser.resources
          @success   = !( parser.type_name == 'error' )
        end
      else
        @success  = false
        @resources << Unimatrix::Error.new(
          message: "#{ @code }: #{ http_response.message }."
        )
      end
    end

  end

end
