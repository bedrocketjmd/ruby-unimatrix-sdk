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
    field   :created_at,   read_only: true
    field   :updated_at,   read_only: true
    field   :destroyed_at, read_only: true

    has_many :activities
    has_one  :realm
  end

end
