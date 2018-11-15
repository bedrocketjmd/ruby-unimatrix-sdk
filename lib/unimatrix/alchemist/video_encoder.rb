module Unimatrix::Alchemist

  class VideoEncoder < Unimatrix::Resource

    field :id
    field :uuid
    field :state
    field :realm_uuid
    field :created_at
    field :updated_at
    field :clipping_enabled

    has_many :rendition_profiles
    has_many :videos

  end

end
