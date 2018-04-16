module Unimatrix

  class AuthorizationError < StandardError

      def initialize( message = nil )

        message = 'Error: Authorization has failed.' if message.nil?

        super( message )

      end

    end

end
