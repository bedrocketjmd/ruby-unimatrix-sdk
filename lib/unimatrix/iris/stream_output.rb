module Unimatrix::Iris

  class StreamOutput < Unimatrix::Resource

    field :id
    field :created_at
    field :updated_at
    field :uuid
    field :key
    field :url
    field :state
    field :stream_id
    field :stream_uuid
    field :authentication_username
    field :authentication_password
    field :realm_uuid

  end

end