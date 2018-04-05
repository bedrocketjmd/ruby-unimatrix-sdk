module Unimatrix::Archivist

  class Component < Unimatrix::DynamicResource
    
    field    :id
    field    :uuid
    field    :realm_uuid
    field    :type_name
    field    :created_at, read_only: true
    field    :updated_at, read_only: true
    
    has_one  :artifact
    has_many :errors

  end

end
