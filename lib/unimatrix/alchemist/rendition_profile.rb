module Unimatrix::Alchemist

  class RenditionProfile < Unimatrix::DynamicResource

    field :id
    field :uuid
    field :height
    field :width
    field :content_type
    field :bit_rate
    field :created_at
    field :updated_at

    has_many :renditions
    has_many :activity_proxies
    has_many :encoders

  end

end