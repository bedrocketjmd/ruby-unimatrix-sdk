module Unimatrix::Alchemist

  class Video < Unimatrix::Resource

    field :id
    field :uuid
    field :realm_uuid
    field :name
    field :input_url
    field :storage_url
    field :content_length
    field :created_at
    field :updated_at
    field :legacy_id

    field :content_type
    field :codec
    field :codec_long
    field :pixel_format
    field :profile
    field :height
    field :width
    field :resolution
    field :bit_rate
    field :level
    field :frame_rate
    field :duration
    field :display_aspect_ratio
    field :storage_aspect_ratio
    field :audio_codec
    field :audio_codec_long
    field :audio_channels
    field :audio_channel_layout
    field :audio_bit_rate
    field :audio_sample_rate

    has_many :video_encoders
    has_many :renditions
    has_many :activity_proxies

  end

end