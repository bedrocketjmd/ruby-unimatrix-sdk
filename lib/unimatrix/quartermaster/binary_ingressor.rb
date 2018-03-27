module Unimatrix::Quartermaster

  class BinaryIngressor < Unimatrix::Resource

    field      :binary_uuid
    field      :state,  read_only: true
    field      :created_at,  read_only: true
    field      :updated_at,  read_only: true
    field      :uuid
    field      :url
    field      :realm_uuid,  read_only: true
    
  end

end
