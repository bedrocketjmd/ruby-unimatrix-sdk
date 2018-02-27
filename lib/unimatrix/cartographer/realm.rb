module Unimatrix::Cartographer

  class Realm < Unimatrix::DynamicResource

    field :id
    field :uuid
    field :created_at
    field :updated_at

    has_many :regions
    
  end

end