module Unimatrix::Cartographer

  class GeographicArea < Unimatrix::DynamicResource

    field :id
    field :type_name
    field :name
    field :uuid
    field :parent_uuid
    field :code
    field :created_at
    field :updated_at

    has_many :regions
    
  end

end