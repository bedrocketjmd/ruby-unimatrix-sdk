module Unimatrix

  class BlueprintOperation < Unimatrix::Operation

    @@blueprints = {}

    def initialize( realm_uuid, options = {} )
      @realm_uuid = realm_uuid
      super( "/realms/#{ realm_uuid }/blueprints", options )
    end

    def read
      @@blueprints[ @realm_uuid ] ||= begin
        blueprints = []

        offset = 0
        segment_count = 10
        total = nil
        errors = nil

        while total.nil? || offset < total
          operation = self.offset( offset ).include( 'blueprint_attributes' )

          operation.read do | resources, response |

            if !response.body[ 'errors' ].nil?
              errors = response.body[ 'errors' ]
              break
            end

            offset += segment_count
            total = response.body[ '$this' ][ 'unlimited_count' ]

            blueprints += resources
          end

          break if !errors.nil?
        end

        blueprints

      end
    end

  end
end
