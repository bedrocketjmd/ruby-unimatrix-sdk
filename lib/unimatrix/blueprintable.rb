module Unimatrix

  class Blueprintable < Resource

    class << self

      def new( attributes = {}, associations = {} )
        module_name = Unimatrix.const_get( self.name.split( '::' )[1].underscore.camelize )
        entity_name = self.name.split( '::' ).last.underscore.camelize
        entity_type_name = attributes[ 'type_name' ].camelize

        klass = ( module_name.const_get( entity_name ) rescue nil )

        unless module_name.const_defined?( entity_type_name )
          typed_klass = Class.new( klass )
          klass = module_name.const_set( entity_type_name, typed_klass )
        else
          klass = module_name.const_get( entity_type_name )
        end

        klass
      end
    end

    def initialize( attributes = {}, associations = {} )
      blueprints = unimatrix_operation(
        "/realms/#{ attributes[ "realm_uuid" ] }/blueprints"
      ).where( {
        "resource_type_name": attributes[ "type_name" ]
      } ).include (
        "blueprint_attributes"
      )

      blueprints = blueprints.read

      unless blueprints.empty?
        blueprint = blueprints.first rescue nil

        blueprints.each do | b |
          unless b.realm_uuid.nil?
            blueprint = b
          end
        end

        if blueprint.respond_to?( 'blueprint_attributes' )
          blueprint_attributes = blueprint.blueprint_attributes

          self.class_eval do
            blueprint_attributes.each do | attribute |
              field attribute.name
            end
          end
        end
      end

      super( attributes, associations )
      yield self if block_given?
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
