module Unimatrix::Curator

  class ActivityReference < Unimatrix::DynamicResource
    field    :id
    field    :type_name
    field    :subject_uuid
    field    :subject_type
    field    :state
    field    :message
    field    :properties
    field    :source_uuid
    field    :execute_at
    field    :completed_at
    field    :created_at,   read_only: true
    field    :updated_at,   read_only: true
    field    :destroyed_at, read_only: true

    has_one  :realm
  end

end
