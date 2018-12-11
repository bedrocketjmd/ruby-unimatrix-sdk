module Unimatrix::Historian

  class History < Unimatrix::Resource

    field :id
    field :uuid
    field :created_at
    field :realm_uuid
    field :resource_uuid
    field :resource_owner_uuid
    field :resource_server
    field :resource_name
    field :action_name
    field :at

  end

end