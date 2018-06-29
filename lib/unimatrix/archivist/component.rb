module Unimatrix::Archivist

  class Component < Unimatrix::Resource

    field    :id
    field    :uuid
    field    :realm_uuid
    field    :type_name
    field    :created_at
    field    :updated_at
    field    :destroyed_at

    has_one  :artifact
    has_many :errors

  end

end
