module Unimatrix::Player

  class Media < Unimatrix::Resource

    field :id
    field :uuid
    field :realm_uuid
    field :provider
    field :provider_uid
    field :type_name
    field :media_type
    field :name
    field :poster_url
    field :sprite_url
    field :stream_type
    field :state_url

    has_many :media_sources
    has_many :media_texts

  end

end
