module Unimatrix::Authorization

  class Railtie < Rails::Railtie
    initializer "unimatrix.authorization.configure_controller" do | app |
      ActiveSupport.on_load :action_controller do
        include Unimatrix::Authorization
      end
    end
  end

  def retrieve_policies( resource_name, access_token, realm_uuid, resource_server )
    if resource_name && access_token
      key = [ resource_name, access_token, realm_uuid, resource_server ].join

      Rails.cache.fetch(
        "keymaker-policies-#{ Digest::SHA1.hexdigest( key ) }",
        expires_in: 1.minute
      ) do
        request_policies( resource_name, access_token, realm_uuid, resource_server )
      end
    end
  end

  def retrieve_resource_owner( access_token )
    if access_token
      Rails.cache.fetch(
        "keymaker-resource_owner-#{ Digest::SHA1.hexdigest( access_token ) }",
        expires_in: 1.minute
      ) do
        request_resource_owner( access_token )
      end
    end
  end
  
  def retrieve_client_token( client_id, client_secret )
    if client_id && client_secret
      key = [ client_id, client_secret ].join
      
      Rails.cache.fetch(
        "keymaker-client_token-#{ Digest::SHA1.hexdigest( key ) }",
        expires_in: 1.minute
      ) do
        request_client_token( client_id, client_secret )
      end
    end
  end

end
