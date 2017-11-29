module Unimatrix::Activist

  class Activity < Unimatrix::Resource
    field    :id
    field    :type_name
    field    :artifact_id
    field    :subject_id
    field    :subject_type
    field    :state
    field    :uuid
    field    :message
    field    :properties
    field    :completed_at
    field    :destroyed_at
    field    :created_at
    field    :updated_at
    field    :execute_at

    has_many :tasks
    has_one  :realm
  end

end
