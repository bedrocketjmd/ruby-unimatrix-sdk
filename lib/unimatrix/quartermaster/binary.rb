module Unimatrix::Quartermaster

  class Binary < Unimatrix::DynamicResource

    field :filename
    field :content_length
    field :content_type
    field :realm_uuid,  read_only: true
    field :created_at,  read_only: true
    field :updated_at,  read_only: true
    field :uuid
    field :storage_key

    has_one :binaries_ingressor

  end

end
