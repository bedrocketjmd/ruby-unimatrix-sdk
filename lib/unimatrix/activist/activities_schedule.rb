module Unimatrix::Activist

  class ActivitiesSchedule < Unimatrix::DynamicResource
    field :id
    field :interval
    field :period
    field :minute
    field :hour
    field :day
    field :month
    field :expires_at
    field :created_at
    field :updated_at

    has_one  :realm
    has_many :activities
  end

end
