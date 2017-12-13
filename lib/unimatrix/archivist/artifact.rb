module Unimatrix::Archivist

  class Artifact < Unimatrix::DynamicResource
    field    :creator_uuid
    field    :picture_uuid
    field    :provider
    field    :provider_uid
    field    :provider_url
    field    :description
    field    :short_description
    field    :slug
    field    :note
    field    :type_name
    field    :component_ids
    field    :relationships
    field    :name
    field    :created_at
    field    :updated_at

  end

end
