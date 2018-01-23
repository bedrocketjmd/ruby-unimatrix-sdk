module Unimatrix

  class Blueprintable < Resource

    class << self
      alias old_new new

      def new( attributes = {}, associations = {} )
        Class.new( self ).old_new(
          { type_name: self.name.split( '::' ).last.underscore }.
            merge( attributes ),
          associations
        )
      end
    end

    def initialize( attributes = {}, associations = {} )

      blueprint = unimatrix_operation(
        "/realms/#{ attributes[ "realm_uuid" ] }/blueprints"
      ).where( {
        "resource_type_name": attributes[ "type_name" ]
      } ).include (
        "blueprint_attributes"
      )

      blueprint = blueprint.read.first
      blueprint_attributes = blueprint.blueprint_attributes

      self.class_eval do
        blueprint_attributes.each do | attribute |
          field attribute.name
        end
      end

      super( attributes, associations )
      yield self if block_given?

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
