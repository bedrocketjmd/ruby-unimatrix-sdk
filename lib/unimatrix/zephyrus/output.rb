module Unimatrix::Zephyrus

  class Output < Unimatrix::DynamicResource

    field :id
    field :created_at
    field :updated_at
    field :key
    field :uid
    field :uuid
    field :state
    field :input_id

    has_many :renditions
    
  end

end