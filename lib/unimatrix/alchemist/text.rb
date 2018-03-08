module Unimatrix::Alchemist

  class Text < Unimatrix::Resource

    field :id
    field :uuid
    field :realm_uuid
    field :input_url
    field :storage_url
    field :content_type
    field :content_length
    field :video_id
    field :video_uuid
    field :created_at
    field :updated_at

    has_many :renditions
    has_many :activity_proxies

  end

end