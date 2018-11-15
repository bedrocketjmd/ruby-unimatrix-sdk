module Unimatrix::Zephyrus
  
  class Input < Unimatrix::Resource
    
    field :id
    field :created_at
    field :updated_at
    field :state
    field :key
    field :uid
    field :uuid
    field :realm_uuid
    field :provider

    has_many :outputs

  end

end