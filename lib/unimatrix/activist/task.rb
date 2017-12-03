module Unimatrix::Activist

  class Task < Unimatrix::DynamicResource

    field   :id
    field   :type_name
    field   :subject_id
    field   :activity_id
    field   :subject_type
    field   :state
    field   :message
    field   :properties
    field   :execute_at
    field   :started_at
    field   :ended_at
    field   :created_at
    field   :updated_at

    has_one :activity
    
  end

end
