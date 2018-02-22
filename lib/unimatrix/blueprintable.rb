module Unimatrix

  module Blueprintable

    def blueprintable( &block )
      block.call( blueprints )
    end

    def blueprints
      @blueprints ||= begin
        blueprints =
          Unimatrix::Operation.new(
            "/realms/#{ @realm_uuid }/blueprints",
            { access_token: token, count: 100 }
          ).include (
            "blueprint_attributes"
          )

          blueprints.read
      end
    end

    def find_blueprint( entity )
      blueprint = nil

      blueprints.each do | b |
        if ( b.resource_type_name == entity.type_name ) &&
           ( blueprint.nil? || blueprint.realm_uuid.nil? )

          blueprint = b
        end
      end

      blueprint
    end

    def build_with_blueprint( entity )
      begin
        blueprint = find_blueprint( entity )

        unless blueprint.nil?
          klass = typed_class( entity )
          entity = copy_attributes( blueprint, entity )
        end

        klass.new( entity )
      rescue
        entity
      end
    end

    def typed_class( entity )
      klass = nil

      module_name = Unimatrix.const_get( entity.class.name.split( '::' )[1].underscore.camelize )
      entity_type_name = entity.type_name.camelize

      unless module_name.const_defined?( entity_type_name )
        base_class = Class.new( entity.class )
        #base_class = Class.new( Unimatrix::Resource )
        klass = module_name.const_set( entity_type_name, base_class )
      else
        klass = module_name.const_get( entity_type_name )
      end

      klass
    end

    def copy_attributes( blueprint, entity )
      default_attributes = [ "type_name", "relationships", "realm_uuid" ]
      attributes = {}

      if blueprint.respond_to?( 'blueprint_attributes' )
        permitted_attributes = blueprint.blueprint_attributes.map( &:name ) + default_attributes

        permitted_attributes.each do | field |
          attributes[ field ] = entity.send( field ) if entity.respond_to?( field )
        end

      end

      attributes
    end

    protected; def token
      @authorization_token ||= begin
         Unimatrix::Authorization::ClientCredentialsGrant.new(
           client_id:     ENV[ 'KEYMAKER_CLIENT' ],
           client_secret: ENV[ 'KEYMAKER_SECRET' ]
         ).request_token
      end
    end

  end

end
