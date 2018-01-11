module Unimatrix::Archivist
  
  class Blueprint < Unimatrix::DynamicResource
    
    field    :id
    field     :uuid
    field     :realm_uuid
    field     :blueprint_uuid
    field     :name
    field     :readable
    field     :writable
    field     :type
    field     :validates_uniqueness
    field     :validates_uniqueness_scope
    field     :validates_presence
    field     :validates_absence
    field     :validates_format_with
    field     :validates_format_without
    field     :validates_length_minimum
    field     :validates_length_maximum
    field     :validates_in
    field     :validates_not_in
    field     :validates_numeric
    field     :validates_numeric_integer
    field     :validates_numeric_minimum
    field     :validates_numeric_maximum
    field     :validates_type
    field     :created_at
    field     :updated_at
    
    has_many :errors
    
  end
end
