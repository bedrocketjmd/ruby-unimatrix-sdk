module Unimatrix::Authorization

  class Parser

    def initialize( content = {} )
      @content = content
      yield self if block_given?
    end

    def name
      @content.keys.present? ? @content.keys.first : nil
    end

    def type_name
      self.name.present? ? name.singularize : nil
    end

    def resources
      result = nil

      unless self.name.blank?
        if @content[ 'error' ]
          result = parse_resource( name, @content )
        else
          unless @content[ name ].is_a?( Array )
            @content[ name ] = [ @content[ name ] ]
          end
          result = @content[ name ].map do | attributes |
            self.parse_resource( name, attributes )
          end
        end
      end
      result
    end

    def parse_resource( name, attributes )
      resource = nil

      if attributes.present?
        class_name = name.singularize.camelize
        object_class = Unimatrix::Authorization.const_get( class_name ) rescue nil

        if object_class.present?
          resource = object_class.new( attributes )
        elsif name == 'uuid' && attributes.is_a?( String )
          binding.pry
          resource = ResourceOwner.new( { "uuid" => attributes } )
        end
      end
      resource
    end
    
  end

end
