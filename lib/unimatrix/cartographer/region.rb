module Unimatrix::Cartographer

  class Region < Unimatrix::DynamicResource

    field :id
    field :uuid
    field :name
    field :realm_id
    field :created_at
    field :updated_at

    has_many :geographic_areas
    has_many :region_geographic_areas
    
  end

end