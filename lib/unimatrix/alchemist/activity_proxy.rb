module Unimatrix::Alchemist

  class ActivityProxy < Unimatrix::DynamicResource

    field :id
    field :uuid
    field :realm_uuid
    field :state
    field :progress
    field :message
    field :rendition_profile_id
    field :rendition_profile_uuid
    field :video_id
    field :video_uuid
    field :text_id
    field :text_uuid
    field :created_at
    field :updated_at

    has_many :renditions

  end

end