module Unimatrix::Iris

  class StreamTranscriber < Unimatrix::DynamicResource

    field :id
    field :created_at
    field :updated_at
    field :uuid
    field :state
    field :minimum_segment_duration
    field :maximum_segment_duration
    field :stream_id
    field :stream_uuid

  end

end