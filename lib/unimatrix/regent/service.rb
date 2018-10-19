module Unimatrix::Regent

  class Service < Unimatrix::DynamicResource
    field    :id
    field    :uuid
    field    :provider
    field    :type
    field    :provider_uid
    field    :authorized
    field    :properties
    field    :realm_uuid
    field    :created_at
    field    :updated_at

    has_one  :realm
  end

end
