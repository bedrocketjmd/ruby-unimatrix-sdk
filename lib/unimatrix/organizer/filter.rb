module Unimatrix::Organizer

  class Filter < Unimatrix::Resource

    field    :id
    field    :uuid
    field    :type_name
    field    :realm_uuid
    field    :operator
    field    :created_at
    field    :updated_at

    has_many :filter_criteria

  end

end
