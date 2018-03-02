module Unimatrix::Regent

  class Realm < Unimatrix::DynamicResource
    
    field    :id
    field    :uuid
    field    :name
    field    :code_name
    field    :created_at
    field    :updated_at
    field    :domain_name

    has_many :settings
    
  end

end