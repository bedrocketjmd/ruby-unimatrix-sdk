module Unimatrix::Distributor

  class Destination < Resource
    field    :id
    field    :uuid
    field    :realm_uuid
    field    :type_name
    field    :created_at
    field    :updated_at
    field    :destroyed_at

    has_one  :realm
  end

end
