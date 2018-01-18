module Unimatrix

  class Blueprintable < Resource

    class << self

    end

    def initialize( attributes = {}, associations = {} )

      blueprint = unimatrix_operation(
        "/realms/#{ attributes[ "realm_uuid" ] }/blueprints"
      ).where( {
        "resource_type_name": attributes[ "type_name" ]
      } ).include (
        "blueprint_attributes"
      ).read.first

      binding.pry

    end

    protected; def token
      @authorization_token ||= begin
         Unimatrix::Authorization::ClientCredentialsGrant.new(
           client_id:     ENV[ 'KEYMAKER_CLIENT' ],
           client_secret: ENV[ 'KEYMAKER_SECRET' ]
         ).request_token
      end
    end

    protected; def unimatrix_operation( endpoint, args = {} )
      Unimatrix::Operation.new(
          endpoint,
          args.merge( { access_token: token } )
      )
    end

  end

end
