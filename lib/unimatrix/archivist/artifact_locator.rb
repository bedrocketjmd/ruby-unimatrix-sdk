module Unimatrix::Archivist

  class ArtifactLocator < Unimatrix::Resource
    
    field      :id
    field      :uuid
    field      :provider
    field      :type_name
    field      :realm_uuid
    field      :created_at
    field      :updated_at
    field      :artifact_uuid
    field      :provider_url
    field      :provider_uid
    field      :destroyed_at
    
    has_one  :artifact
    has_many :errors

  end

end
