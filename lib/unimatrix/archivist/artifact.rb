module Unimatrix::Archivist

  class Artifact < Unimatrix::Resource

    include Unimatrix::Blueprintable

    field    :id
    field    :uuid
    field    :realm_uuid
    field    :type_name
    field    :language
    field    :creator_uuid
    field    :picture_uuid
    field    :provider
    field    :provider_uid
    field    :provider_url
    field    :name
    field    :short_name
    field    :description
    field    :short_description
    field    :slug
    field    :note
    field    :legacy_id
    field    :legacy_uid
    field    relationships: [ :category, :person, :season, :asset, :athlete, :service_provider ]
    field    :created_at
    field    :updated_at
    field    :originated_at
    field    :destroyed_at

    has_many :artifact_locators
    has_many :artifact_relationships
    has_many :components
    has_many :errors

  end

end
