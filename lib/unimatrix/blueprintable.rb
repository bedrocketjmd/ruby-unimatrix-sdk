module Unimatrix

  module Blueprintable

    def blueprintable( &block )
      block.call( blueprints )
    end

    def blueprints
      @blueprints ||= begin
        blueprints =
          Unimatrix::Operation.new(
            "/realms/#{ @realm_uuid } }/blueprints",
            { access_token: token }
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
      blueprint = find_blueprint( entity )
      klass = typed_class( blueprint, entity )

      klass.new( JSON.parse( entity.to_json ) )
      #associations?
    end

    def typed_class( blueprint, entity )
      klass = nil

      unless blueprint.nil?
        module_name = Unimatrix.const_get( entity.class.name.split( '::' )[1].underscore.camelize )
        entity_type_name = entity.type_name.camelize

        unless module_name.const_defined?( entity_type_name )
          base_class = Class.new( entity.class )
          #base_class = Class.new( Unimatrix::Resource )
          klass = module_name.const_set( entity_type_name, base_class )
        else
          klass = module_name.const_get( entity_type_name )
        end
      end

      #add_attributes_to_typed_class( blueprint, klass )
      klass
    end

    def add_attributes_to_typed_class( blueprint, klass )
      if blueprint.respond_to?( 'blueprint_attributes' )
        blueprint_attributes = blueprint.blueprint_attributes

        #calls field on the class per blueprint attribute
           #is this enough? wont I need fields on the base class
        #returns the klass

      end
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
