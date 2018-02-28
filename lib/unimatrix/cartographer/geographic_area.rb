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
    has_many :region_geographic_areas
    
  end

end