module Unimatrix::Iris

  class StreamRecorder < Unimatrix::Resource

    field :id
    field :created_at
    field :updated_at
    field :uuid
    field :duration
    field :state
    field :recording_state
    field :duration_limit
    field :stream_id
    field :stream_uuid
    field :realm_uuid

  end

end