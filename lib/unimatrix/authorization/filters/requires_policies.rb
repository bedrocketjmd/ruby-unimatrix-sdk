module Unimatrix::Authorization

  class RequiresPolicies
    def initialize( resource, options = {} )
      @resource_name = resource
      @resource_server = options[ :resource_server ] || ENV[ 'APPLICATION_NAME' ]
    end

    def before( controller )
      client_id     = Unimatrix.configuration.client_id
      client_secret = Unimatrix.configuration.client_secret

      access_token =
        if controller.params[ 'access_token' ].present?
          controller.params[ 'access_token' ]
        else
          controller.retrieve_client_token( client_id, client_secret )
        end

      realm_uuid =
        if controller.respond_to?( :realm_uuid )
          controller.realm_uuid
        elsif controller.respond_to?( :realm )
          controller.realm.uuid
        else
          controller.params[ :realm_uuid ]
        end

      if access_token.present?
        policies = controller.retrieve_policies(
          @resource_name,
          access_token,
          realm_uuid,
          @resource_server
        )

        if policies.present? && policies.is_a?( Array ) &&
           policies.first.type_name == 'policy'
          controller.policies = policies
          forbidden = true
          policies.each do | policy |
            if policy.actions.include?( controller.action_name )
              forbidden = false
            end
          end

          if forbidden
            controller.render_error( ::MissingPolicyError )
          end
        else
          controller.render_error( ::MissingPolicyError )
        end
      else
        controller.render_error( ::MissingTokenError )
      end
    end
  end

  module ClassMethods
    def requires_policies( resource, options = {} )
      before_action(
        RequiresPolicies.new( resource, options ),
        options
      )
    end
  end

  def self.included( controller )
    controller.extend( ClassMethods )
  end

  def policies=( attributes )
    @policies = attributes
  end

  def policies
    @policies ||= begin
      # Used by Archivist requires_permission filter. TODO: deprecate
      retrieve_policies(
        @resource_name,
        params[ :access_token ],
        realm_uuid,
        @resource_server
      )
    end
  end

  # In Rails app, this is overwritten by #retrieve_policies in railtie.rb
  def retrieve_policies( resource_name, access_token, realm_uuid, resource_server )
    if resource_name && access_token
      request_policies(
        resource_name,
        access_token,
        realm_uuid,
        resource_server
      )
    else
      nil
    end
  end

  def request_policies( resource_name, access_token, realm_uuid, resource_server )
    if resource_name && access_token
      realm_uuid = realm_uuid || '*'
      Operation.new( '/policies' ).where(
        access_token: access_token,
        resource: "realm/#{ realm_uuid }::#{ resource_server }::#{ resource_name }/*"
      ).read
    else
      nil
    end
  end

  def request_client_token( client_id, client_secret )
    if client_id && client_secret
      ClientCredentialsGrant.new(
        client_id: client_id,
        client_secret: client_secret
      ).request_token( with_expiry: true )
    else
      nil
    end
  end

end
