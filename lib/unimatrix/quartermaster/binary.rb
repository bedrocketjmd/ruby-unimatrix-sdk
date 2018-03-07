module Unimatrix::Quartermaster

  class Binary < Unimatrix::DynamicResource

    field :id
    field :filename
    field :content_length
    field :content_type
    field :realm_uuid
    field :created_at,  read_only: true
    field :updated_at,  read_only: true
    field :uuid
    field :storage_key

    has_many :binaries_ingressors

  end

end
