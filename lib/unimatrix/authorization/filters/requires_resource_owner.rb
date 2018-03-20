module Unimatrix::Authorization
  
  class RequiresResourceOwner
    def initialize( resource, options = {} )
      @resource_name = resource
      @resource_server = options[ :resource_server ] || ENV[ 'APPLICATION_NAME' ]
    end
    
    def before( controller )
      access_token = controller.params[ 'access_token' ]
      
      realm_uuid = begin 
        if controller.respond_to?( :realm_uuid )
          controller.realm_uuid
        elsif controller.respond_to?( :realm )
          controller.realm.uuid
        else
          controller.params[ :realm_uuid ]
        end
      end

      if access_token.present?
        resource_owner =
          controller.request_resource_owner( 
            @resource_name, 
            access_token, 
            realm_uuid, 
            @resource_server 
          )
          
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
    def requires_resource_owner( resource, options = {} )
      before_action(
        RequiresResourceOwner.new( resource, options ),
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
      request_resource_owner( 
        @resource_name,
        params[ :access_token ],
        realm_uuid,
        @resource_server
      )
    end
  end
  
  def request_resource_owner( resource_name, access_token, realm_uuid, resource_server )
    if resource_name && access_token
      realm_uuid = realm_uuid || '*'
      Operation.new( '/resource_owner' ).where(
        access_token: access_token,
        resource: "realm/#{ realm_uuid }::#{ resource_server }::#{ resource_name }/*"
      ).read
    end
  end
    
end