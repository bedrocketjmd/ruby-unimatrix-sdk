module Unimatrix

  class Serializer

    def initialize( payload = [], options = {} )
      @payload = [ payload ].flatten
      @options = options
    end

    def serialize( node, options = {} )
      result = {}
      result[ node ] = @payload.map do | object |
        node_object = {}
        node_object[ :type_name ] = (
          object.respond_to?( :type_name ) ?
            object.type_name :
            object.class.name.split( '::' ).last.underscore
        )
        if object.respond_to?( :fields )
          object.fields.each do | name, options |
            unless options[ :read_only ]
              value = object.send( name ) if object.respond_to?( name )
              if value.is_a?( Struct )
                nested_attributes = value.members
                nested_attributes.each do | nested_attribute |
                  key = "#{ name }.#{ nested_attribute }"
                  node_object[ key.to_sym ] = value.send( nested_attribute )
                end
              else
                node_object[ name.to_sym ] = value
              end
            end
          end
        end
        node_object
      end
      result
    end

  end

end
