module Unimatrix::Alchemist

  class AwsRenditionProfile < RenditionProfile

    field :preset_id
    field :transcoder 
    field :encryption
    field :encryption_system_id
    field :encryption_url
    field :encryption_static_key
    field :encryption_static_url

  end

end