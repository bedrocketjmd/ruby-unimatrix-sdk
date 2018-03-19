require 'pry'
require 'pry-nav'
module Unimatrix

  class Resource

    class << self
      
      def inherited( subclass ) 
        @@descendants_by_type_name = nil 
        subclass.nested_fields = {}.merge( self.nested_fields )
        subclass.fields = {}.merge( self.fields )
      end

      def type_name
        name.present? ? name.split( '::' ).last.underscore : nil
      end

      def find_by_type_name( type_name )
        @@descendants_by_type_name ||= begin
          result = {}
          descendants.each do | descendant |
            descendant_type_name = descendant.type_name
            result[ descendant_type_name ] = descendant \
              unless descendant_type_name.blank?
          end
          result
        end
        @@descendants_by_type_name[ type_name ]
      end

      def build( attributes = {}, associations = {} )
        new( attributes.transform_keys( &:to_s ), associations )
      end

      def field( name, options = {} )
        if name.is_a?( Hash )
          nested_field_key = name.keys.first
          self.nested_fields[ nested_field_key ] = name[ nested_field_key ]
          name = nested_field_key
        end

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
    class_attribute :nested_fields, instance_writer: false

    self.fields = {}
    self.nested_fields = {}

    field :type_name
    has_many  :errors

    def initialize( attributes={}, associations={} )

      self.nested_fields.each do | key, value |
        self.send( "#{ key }=", Struct.new( *value ).new )
      end

      self.type_name = self.class.name.split( '::' ).last.underscore rescue nil

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
