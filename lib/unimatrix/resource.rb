module Unimatrix

  class Resource

    class << self

      def inherited( subclass )
        subclass.fields = {}.merge( self.fields )
      end

      def type_name
        name.present? ? name.split( '::' ).last.underscore : nil
      end

      def find_by_type_name( type_name )
        @descendants_by_type_name = begin
          result = {}
          descendants.each do | descendant |
            descendant_type_name = descendant.type_name
            result[ descendant_type_name ] = descendant \
              unless descendant_type_name.blank?
          end
          result
        end
        @descendants_by_type_name[ type_name ]
      end

      def create_by_type_name( type_name, base_type_name )

        resource_class = find_by_type_name( type_name ) 
        
        if resource_class.nil?
          resource_superclass = find_by_type_name( base_type_name )
          unless resource_superclass.nil? 
            resource_module_name = 
              resource_superclass.name.split( '::' )[ 0..-2 ].join( '::' )
            resource_module = resource_module_name.blank? ?
              Object : resource_module_name.constantize 
            resource_class = resource_module.const_set(
              type_name.classify, Class.new( resource_superclass )
            )
          end
        end

        resource_class
        
      end

      def field( name, options = {} )
        self.fields[ name.to_sym ] = options.merge( name: name )

        class_eval(
          "def #{ name }(); " +
          "@#{ name }.is_a?( FalseClass ) ? @#{ name } : (" +
             "@#{ name } || " +
               ( options[ :default ].nil? ?
                  "nil" :
                  ( options[ :default ].is_a?( String ) ?
                      "'#{ options[ :default ] }'" :
                        "#{ options[ :default ] }" ) ) + ");" +
          "end;" +
          " " +
          "attr_writer :#{ name };",
          __FILE__,
          __LINE__
        )

      end

      def has_one( name, options = {} )
        define_method name do
          associations = self.instance_variable_get( "@_#{ name.to_s.pluralize }" )
          associations.present? ? associations.first : options[ :default ]
        end
      end

      def has_many( name, options = {} )
        define_method name do
          self.instance_variable_get( "@_#{ name }" ) ||
          options[ :default ] || []
        end
      end

    end

    class_attribute :fields, instance_writer: false
    self.fields = {}

    field :type_name
    has_many  :errors

    def initialize( attributes={}, associations={} )

      self.type_name = self.class.name.split( '::' ).last.underscore

      attributes.each do | key, value |
        send( "#{ key }=", value ) if self.respond_to?( "#{ key }=" )
      end

      associations.each do | key, value |
        self.instance_variable_set( "@_#{ key }", value )
      end

      yield self if block_given?
    
    end

  end

end
