module Unimatrix::Authorization

  class RequiresResourceOwner

    def before( controller )
      access_token = controller.params[ 'access_token' ]

      if access_token.present?
        resource_owner = controller.request_resource_owner( access_token )

        if resource_owner.present? && resource_owner.is_a?( Array ) &&
           resource_owner.first.type_name == 'resource_owner'
          controller.resource_owner = resource_owner
        else
          controller.render_error(
            ::ForbiddenError,
            "The requested resource_owner could not be retrieved."
          )
        end
      else
        controller.render_error(
          ::MissingParameterError,
          "The parameter 'access_token' is required."
        )
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
      request_resource_owner( params[ :access_token ] )
    end
  end

  def request_resource_owner( access_token )
    if access_token
      Operation.new( '/resource_owner' ).where(
        access_token: access_token
      ).read
    end
  end

end