module Unimatrix::Authorization

  class Policy < Unimatrix::Resource

    field :id
    field :created_at
    field :updated_at
    field :resource
    field :realm_uuid
    field :actions

  end

end