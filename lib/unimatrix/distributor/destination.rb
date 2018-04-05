module Unimatrix::Distributor

  class Destination < Unimatrix::DynamicResource
    field    :id
    field    :uuid
    field    :realm_uuid
    field    :type_name
    field    :created_at,   read_only: true
    field    :updated_at,   read_only: true
    field    :destroyed_at, read_only: true

    has_one  :realm
  end

end
