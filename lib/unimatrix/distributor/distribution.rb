module Unimatrix::Distributor

  class Distribution < Base
    field    :id
    field    :uuid
    field    :realm_uuid
    field    :type_name
    field    :state
    field    :message
    field    :properties
    field    :artifact_uuid
    field    :add_at
    field    :added_at
    field    :change_at
    field    :changed_at
    field    :remove_at
    field    :removed_at

    has_many :activities
    has_one  :realm
  end

end
