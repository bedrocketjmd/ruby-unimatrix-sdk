module Unimatrix

  class DynamicResource < Resource

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
