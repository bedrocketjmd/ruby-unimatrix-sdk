module Unimatrix::Regent

  class Realm < Unimatrix::Resource

    field    :id
    field    :uuid
    field    :name
    field    :code_name
    field    :created_at
    field    :updated_at
    field    :domain_name
    field    :picture_uuid

    has_many :settings

  end

end
