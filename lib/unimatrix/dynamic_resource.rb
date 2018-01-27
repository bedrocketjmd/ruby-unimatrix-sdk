module Unimatrix

  class DynamicResource < Resource

    class << self

      alias build new

      def new( attributes = {}, associations = {} )
        klass = base_class( attributes )

        klass.build(
          attributes,
          associations
        )
      end

      def base_class( attributes )
        module_name = Unimatrix.const_get( self.name.split( '::' )[1].underscore.camelize )
        entity_name = self.name.split( '::' ).last.underscore.camelize

        ( module_name.const_get( entity_name ) rescue Class )
      end

    end

    def initialize( attributes = {}, associations = {} )

      unsupported_attributes_names = []
      attributes.each do | key, value |
        unsupported_attributes_names << key.to_sym \
          unless self.respond_to?( key.to_sym )
      end

      self.class_eval do
        unsupported_attributes_names.each do | name |
          field name
        end
      end

      super( attributes, associations )
      yield self if block_given?

    end

  end

end
