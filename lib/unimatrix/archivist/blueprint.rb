module Unimatrix::Archivist

  class Blueprint < Unimatrix::Resource
    
    field    :id
    field    :uuid
    field    :realm_uuid
    field    :type_name
    field    :name
    field    :resource_class_name
    field    :resource_type_name
    field    :created_at
    field    :updated_at
    
    has_many :blueprint_attributes
    has_many :errors

  end

end
