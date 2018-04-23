module Unimatrix::Historian

  class History < Unimatrix::Resource
    field    :id
    field    :uuid
    field    :realm_uuid
    field    :resource_uuid
    field    :resource_owner_uuid
    field    :resource_server
    field    :resource_name
    field    :action_name
    field    :at
    field    :created_at
  end

end