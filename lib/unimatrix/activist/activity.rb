module Unimatrix::Activist

  class Activity < Unimatrix::DynamicResource
    field    :id
    field    :type_name
    field    :artifact_uuid
    field    :subject_uuid
    field    :subject_type
    field    :state
    field    :uuid
    field    :message
    field    :properties
    field    :completed_at
    field    :execute_at
    field    :expire_at
    field    :activities_schedule_id
    field    :created_at,            read_only: true
    field    :updated_at,            read_only: true
    field    :destroyed_at,          read_only: true

    has_many :tasks
    has_one  :realm
  end

end
