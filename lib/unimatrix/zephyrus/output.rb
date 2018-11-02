module Unimatrix::Zephyrus

  class Output < Unimatrix::Resource

    field :id
    field :created_at
    field :updated_at
    field :key
    field :uid
    field :uuid
    field :state
    field :input_id
    field :realm_uuid
    field :provider

    has_many :renditions
    
  end

end