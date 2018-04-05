module Unimatrix::Archivist

  class Artifact < Unimatrix::Resource

    include Unimatrix::Blueprintable

    field    :id
    field    :creator_uuid
    field    :picture_uuid
    field    :provider
    field    :provider_uid
    field    :provider_url
    field    :description
    field    :short_description
    field    :short_name
    field    :originated_at
    field    :slug
    field    :note
    field    :type_name
    field    :language
    field    :uuid
    field    :realm_uuid
    field    :component_uuids
    field    relationships: [ :category, :person, :season, :asset, :athlete ]
    field    :name
    field    :created_at,   read_only: true
    field    :updated_at,   read_only: true
    field    :destroyed_at, read_only: true

    has_many :artifact_locators
    has_many :artifact_relationships
    has_many  :errors

  end

end
