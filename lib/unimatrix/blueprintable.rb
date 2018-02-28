module Unimatrix

  module Blueprintable

    @module_members = []

    def self.included( klass )
      @module_members << klass

      class << klass
        cattr_accessor :blueprints

        def find_blueprint( class_type_name )
          blueprint = nil

          self.blueprints.each do | b |
            if ( b.resource_type_name == class_type_name ) &&
               ( blueprint.nil? || blueprint.realm_uuid.nil? )

              blueprint = b
            end
          end

          blueprint
        end

        def build( attributes = {}, associations = {} )
          blueprint = find_blueprint( attributes[ 'type_name' ] ) rescue nil
          klass = build_typed_class( attributes, blueprint )
          klass.new( attributes, associations ) rescue nil
        end

        def build_typed_class( attributes, blueprint )
          base_class = Class.new( self )
          klass = base_class

          if !blueprint.nil?
            module_name = Unimatrix.const_get( self.name.split( '::' )[1].underscore.camelize )
            entity_type_name = attributes[ 'type_name' ].camelize + attributes[ 'realm_uuid' ]

            unless module_name.const_defined?( entity_type_name )
              klass = module_name.const_set( entity_type_name, base_class )

              default_attributes = [ "type_name", "relationships", "realm_uuid" ]

              if blueprint.respond_to?( 'blueprint_attributes' )
                permitted_attributes = blueprint.blueprint_attributes.map( &:name ) + default_attributes

                klass.instance_eval do
                  permitted_attributes.each do | field_name |
                    field field_name.to_sym
                  end
                end
              end

            else
              klass = module_name.const_get( entity_type_name )
            end
          end

          klass
        end
      end
    end

    def self.assign_blueprints( blueprints )
      @module_members.map{ | klass | klass.blueprints = blueprints }
    end

  end

end
