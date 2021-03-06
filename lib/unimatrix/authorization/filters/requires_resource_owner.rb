module Unimatrix::Authorization

  class RequiresResourceOwner

    def before( controller )
      client_id     = Unimatrix.configuration.client_id
      client_secret = Unimatrix.configuration.client_secret

      access_token =
        if controller.params[ 'access_token' ].present?
          controller.params[ 'access_token' ]
        else
          controller.retrieve_client_token( client_id, client_secret )
        end

      if access_token.present?
        resource_owner = controller.retrieve_resource_owner( access_token )

        if resource_owner.present? && resource_owner.is_a?( Array ) &&
           resource_owner.first.type_name == 'resource_owner'
          controller.resource_owner = resource_owner
        else
          controller.render_error( ::MissingPolicyError )
        end
      else
        controller.render_error( ::MissingTokenError )
      end
    end
  end

  module ClassMethods
    def requires_resource_owner( options = {} )
      before_action(
        RequiresResourceOwner.new,
        options
      )
    end
  end

  def self.included( controller )
    controller.extend( ClassMethods )
  end

  def resource_owner=( attributes )
    @resource_owner = attributes
  end

  def resource_owner
    @resource_owner ||= begin
      retrieve_resource_owner( params[ :access_token ] )
    end
  end

  # In Rails app, this is overwritten by #retrieve_resource_owner in railtie.rb
  def retrieve_resource_owner( access_token )
    if access_token
      request_resource_owner( access_token )
    end
  end

  def request_resource_owner( access_token )
    Operation.new( '/resource_owner' ).where( access_token: access_token ).read
  end

end
