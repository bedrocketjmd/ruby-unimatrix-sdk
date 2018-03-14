module Unimatrix::Analyst

  class Rule < Unimatrix::Resource

    field :id
    field :realm_id
    field :condition
    field :field
    field :value
    field :segment_id
    field :created_at
    field :updated_at
    field :name

  end

end
