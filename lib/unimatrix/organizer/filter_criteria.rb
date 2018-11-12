module Unimatrix::Organizer

  class FilterCriteria < Unimatrix::Resource

    field    :id
    field    :uuid
    field    :realm_uuid
    field    :type_name
    field    :filter_uuid
    field    :condition
    field    :field
    field    :values
    field    :created_at
    field    :updated_at

  end

end