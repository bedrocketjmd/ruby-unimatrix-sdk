module Unimatrix::Archivist

  class ArtifactLocator < Unimatrix::Resource
    
    field      :id
    field      :uuid
    field      :provider
    field      :type_name
    field      :realm_uuid
    field      :artifact_uuid
    field      :provider_url
    field      :provider_uid
    field      :created_at,   read_only: true
    field      :updated_at,   read_only: true
    field      :destroyed_at, read_only: true
    
    has_one  :artifact
    has_many :errors

  end

end
