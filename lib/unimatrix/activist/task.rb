module Unimatrix::Activist

  class Task < Unimatrix::DynamicResource

    field   :id
    field   :type_name
    field   :subject_uuid
    field   :activity_uuid
    field   :subject_type
    field   :state
    field   :message
    field   :properties
    field   :execute_at
    field   :started_at
    field   :ended_at
    field   :created_at, read_only: true
    field   :updated_at, read_only: true

    has_one :activity
    
  end

end
