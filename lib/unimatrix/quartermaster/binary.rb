module Unimatrix::Quartermaster

  class Binary < Unimatrix::DynamicResource

    field :id
    field :filename
    field :content_length
    field :content_type
    field :realm_uuid
    field :created_at
    field :updated_at
    field :properties
    field :uuid
    field :storage_key
    field :realm_uuid

    has_one :binaries_ingressors

  end

end
