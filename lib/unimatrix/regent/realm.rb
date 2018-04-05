module Unimatrix::Regent

  class Realm < Unimatrix::Resource

    field    :id
    field    :uuid
    field    :name
    field    :code_name
    field    :domain_name
    field    :picture_uuid
    field    :created_at,  read_only: true
    field    :updated_at,  read_only: true

    has_many :settings

  end

end
