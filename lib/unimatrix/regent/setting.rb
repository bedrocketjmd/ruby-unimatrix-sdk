module Unimatrix::Regent

  class Setting < Unimatrix::Resource

    field   :id
    field   :realm_id
    field   :name
    field   :content
    field   :created_at, read_only: true
    field   :updated_at, read_only: true

  end

end
