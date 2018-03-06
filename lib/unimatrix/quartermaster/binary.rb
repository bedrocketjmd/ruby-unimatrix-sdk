module Unimatrix::Quartermaster

  class Binary < Unimatrix::Resource

    field :filename
    field :content_length
    field :content_type
    field :realm_uuid
    field :created_at,  read_only: true
    field :updated_at,  read_only: true
    field :uuid, read_only: true
    field :storage_key
    field :realm_uuid,  read_only: true

    has_one :binary_ingressor

  end

end
