module Unimatrix::Authorization
  class Operation < Unimatrix::Operation

    def destroy
      result = nil
      Request.new.tap do | request |
        response = request.destroy( @path, @parameters )
        if response.is_a?( Error ) || response.is_a?( Unimatrix::Error )
          result = response
        elsif response.present?
          result = response.resources
        end
      end
      result
    end

    def read( &block )
      result = nil
      response = nil
      Request.new.tap do | request |
        request.get( @path, @parameters ).tap do | response |
          if response.is_a?( Error ) || response.is_a?( Unimatrix::Error )
            result = response
          else
            result = response.resources
            if block_given?
              case block.arity
                when 0; yield
                when 1; yield result
                when 2; yield result, response
              end
            end
          end
        end
      end
      result
    end

    def write( node, objects, &block )
      result = nil
      Request.new.tap do | request |
        serializer = Unimatrix::Serializer.new( objects )
        response = request.post( @path, @parameters, serializer.serialize( node ) )
        if response.is_a?( Error ) || response.is_a?( Unimatrix::Error )
          result = response
        else
          result = response.resources
          if block_given?
            case block.arity
              when 0; yield
              when 1; yield result
              when 2; yield result, response
            end
          end
        end
      end
      result
    end

    protected; def spawn( parameters )
      Operation.new(
        @path,
        @parameters.deep_merge( parameters || {} )
      )
    end

  end

end