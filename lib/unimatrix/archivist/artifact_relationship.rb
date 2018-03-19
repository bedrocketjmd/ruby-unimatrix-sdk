module Unimatrix::Archivist

  class ArtifactRelationship < Unimatrix::Resource
    
    field    :id
    field    :uuid
    field    :realm_uuid
    field    :name
    field    :type_name
    field    :artifact_uuid
    
    has_one  :artifact
    has_many :errors

  end

end
