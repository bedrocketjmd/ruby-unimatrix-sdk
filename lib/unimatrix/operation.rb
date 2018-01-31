require 'benchmark'

module Unimatrix

  class Operation

    def initialize( path, parameters = {} )
      @path = path
      @parameters = ( parameters || {} ).deep_dup
      @key = nil
    end

    def key
      return @key ||= begin
        result = 0
        query = @parameters.to_param
        if ( @path.present? || @query.present? )
          query = query.split( '&' ).sort.join( '&' )
          addressable = Addressable::URI.new
          addressable.path = @path
          addressable.query = query unless query.blank?
          result = FNV.new.fnv1a_32( addressable.to_s )
        end
        result
      end
    end

    def where( parameters )
      self.spawn( parameters )
    end

    def destroy
      result = nil

      time = Benchmark.measure do

        Request.new.tap do | request |
        response = request.destroy( @path, @parameters )
        if response.present?
          result = response.resources
        end
        end

      end
      print_benchmark("DESTROY", @path, time)
      result
    end

    def limit( _limit )
      self.spawn( count: _limit )
    end

    def offset( _offset )
      self.spawn( offset: _offset )
    end

    def include( *arguments )
      self.spawn( :include => self.normalize_include( *arguments ) )
    end

    def read( &block )
      result = nil
      response = nil
      time = Benchmark.measure do

        Request.new.tap do | request |
        request.get( @path, @parameters ).tap do | response |
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
      print_benchmark("READ", @path, time)
      result
    end

    def write( node, objects, &block )
      result = nil
      time = Benchmark.measure do

        Request.new.tap do | request |
        serializer = Unimatrix::Serializer.new( objects )
        response = request.post( @path, @parameters, serializer.serialize( node ) )
        if response.present?
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
      print_benchmark("WRITE", @path, time)
      result
    end

    def print_benchmark(method, path, time)
      locations = []
      caller_locations(1..5).each{|x| locations << x.label}

      puts "\n BENCHMARK: \n #{method} #{@path} \n ELAPSED #{time.real} \n TRACE: #{locations.join(' -> ')} \n \n"
    end

    protected; def spawn( parameters  )
      Operation.new(
        @path,
        @parameters.deep_merge( parameters || {} )
      )
    end

    protected; def normalize_include( *arguments )

      includes = {}
      arguments.each do | argument |
        case argument
        when Array
          argument.each do | value  |
            includes.deep_merge!( self.normalize_include( value ) )
          end
        when Hash
          argument.each do | key, value |
            if !includes.include?( key ) || includes[ key ] === true
              includes[ key ] = self.normalize_include( value )
            else
              includes[ key ].deep_merge!( self.normalize_include( value ) )
            end
          end
        else
          includes[ argument ] = true
        end
      end
      includes

    end

  end

end
