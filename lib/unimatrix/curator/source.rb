module Unimatrix::Curator

  class Source < Unimatrix::DynamicResource
    field   :id
    field   :uuid
    field   :realm_uuid
    field   :name
    field   :provider
    field   :url
    field   :time_to_live
    field   :last_polled_at
    field   :state
    field   :created_at
    field   :destroyed_at
    field   :updated_at

    has_many :activities
    has_one  :realm
  end

end
