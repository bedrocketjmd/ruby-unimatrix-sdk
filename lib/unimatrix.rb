require 'active_support'
require 'active_support/all'
require 'fnv'

require 'unimatrix/version'

require 'unimatrix/configuration'
require 'unimatrix/operation'
require 'unimatrix/parser'
require 'unimatrix/request'
require 'unimatrix/response'
require 'unimatrix/serializer'

require 'unimatrix/resource'
require 'unimatrix/dynamic_resource'
require 'unimatrix/blueprintable'
require 'unimatrix/blueprint_operation'

require 'unimatrix/error'
require 'unimatrix/attribute_error'
require 'unimatrix/bad_request_error'

# errors
require 'unimatrix/error'
require 'unimatrix/authorization_error'
require 'unimatrix/attribute_error'
require 'unimatrix/bad_request_error'
require 'unimatrix/forbidden_error'
require 'unimatrix/malformed_parameter_error'
require 'unimatrix/missing_parameter_error'
require 'unimatrix/missing_policy_error'
require 'unimatrix/not_found_error'
require 'unimatrix/timeout_error'

# activist
require 'unimatrix/activist/task'
require 'unimatrix/activist/activity'
require 'unimatrix/activist/activities_schedule'

# alchemist
require 'unimatrix/alchemist/activity_proxy'
require 'unimatrix/alchemist/rendition'
require 'unimatrix/alchemist/rendition_profile'
require 'unimatrix/alchemist/text'
require 'unimatrix/alchemist/video'
require 'unimatrix/alchemist/video_encoder'
require 'unimatrix/alchemist/aws_rendition_profile'
require 'unimatrix/alchemist/picture_rendition'
require 'unimatrix/alchemist/sprite_rendition'
require 'unimatrix/alchemist/text_rendition'
require 'unimatrix/alchemist/clipping_rendition'
require 'unimatrix/alchemist/text_storage_activity_proxy'
require 'unimatrix/alchemist/video_encoding_activity_proxy'
require 'unimatrix/alchemist/video_clipping_activity_proxy'
require 'unimatrix/alchemist/video_picture_activity_proxy'
require 'unimatrix/alchemist/video_rendition'
require 'unimatrix/alchemist/video_rendition_interrogation_activity_proxy'
require 'unimatrix/alchemist/video_sprite_activity_proxy'
require 'unimatrix/alchemist/video_storage_interrogation_picture_activity_proxy'

# analyst
require 'unimatrix/analyst/rule'

# archivist
require 'unimatrix/archivist/artifact'
require 'unimatrix/archivist/artifact_locator'
require 'unimatrix/archivist/artifact_relationship'
require 'unimatrix/archivist/blueprint'
require 'unimatrix/archivist/blueprint_attribute'
require 'unimatrix/archivist/component'
require 'unimatrix/archivist/embed_component'
require 'unimatrix/archivist/gallery_component'
require 'unimatrix/archivist/headline_component'
require 'unimatrix/archivist/picture_component'
require 'unimatrix/archivist/section_component'
require 'unimatrix/archivist/text_component'
require 'unimatrix/archivist/unknown_component'
require 'unimatrix/archivist/video_component'

# authorization
require 'unimatrix/authorization/operation'
require 'unimatrix/authorization/parser'
require 'unimatrix/authorization/request'
require 'unimatrix/authorization/response'
require 'unimatrix/authorization/filters/requires_policies' if defined?( Rails )
require 'unimatrix/authorization/filters/requires_resource_owner' if defined?( Rails )
require 'unimatrix/authorization/railtie' if defined?( Rails )
require 'unimatrix/authorization/client_credentials_grant'
require 'unimatrix/authorization/error'
require 'unimatrix/authorization/policy'
require 'unimatrix/authorization/resource'
require 'unimatrix/authorization/resource_owner'
require 'unimatrix/authorization/resource_server'

# cartographer
require 'unimatrix/cartographer/geographic_area'
require 'unimatrix/cartographer/city'
require 'unimatrix/cartographer/continent'
require 'unimatrix/cartographer/country'
require 'unimatrix/cartographer/region'
require 'unimatrix/cartographer/region_geographic_area'
require 'unimatrix/cartographer/territory'

# distributor
require 'unimatrix/distributor/destination'
require 'unimatrix/distributor/distribution'

# iris
require 'unimatrix/iris/stream'
require 'unimatrix/iris/stream_converter'
require 'unimatrix/iris/stream_encoder'
require 'unimatrix/iris/stream_input'
require 'unimatrix/iris/stream_output'
require 'unimatrix/iris/stream_recorder'
require 'unimatrix/iris/stream_transcriber'
require 'unimatrix/iris/stream_transformer'
require 'unimatrix/iris/stream_transmutator'

# player
require 'unimatrix/player/media'
require 'unimatrix/player/media_source'
require 'unimatrix/player/media_text'

# regent
require 'unimatrix/regent/realm'
require 'unimatrix/regent/setting'
require 'unimatrix/regent/service'

# zephyrus
require 'unimatrix/zephyrus/input'
require 'unimatrix/zephyrus/output'
require 'unimatrix/zephyrus/rendition'
require 'unimatrix/zephyrus/conversion_output'
require 'unimatrix/zephyrus/recording_output'
require 'unimatrix/zephyrus/routing_output'
require 'unimatrix/zephyrus/transcoding_output'
require 'unimatrix/zephyrus/transcoding_rendition'
require 'unimatrix/zephyrus/transcribing_output'
require 'unimatrix/zephyrus/transformation_output'
require 'unimatrix/zephyrus/transmutation_output'
require 'unimatrix/zephyrus/transmutation_rendition'

# curator
require 'unimatrix/curator/source'

# quartermaster
require 'unimatrix/quartermaster/binary'
require 'unimatrix/quartermaster/binary_ingressor'

# historian
require 'unimatrix/historian/history'