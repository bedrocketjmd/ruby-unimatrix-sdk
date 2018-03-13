module Unimatrix::Iris

  class Stream < Unimatrix::Resource

    field :id
    field :created_at
    field :updated_at
    field :uuid
    field :name
    field :stream_type
    field :realm_uuid

    has_many :stream_inputs
    has_many :stream_outputs
    has_many :stream_encoders
    has_many :stream_recorders
    has_many :stream_transmutators
    has_many :stream_transcribers

  end

end