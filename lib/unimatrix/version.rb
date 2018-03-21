module Unimatrix
  VERSION = begin
    version = File.read( File.join( __dir__, "../../VERSION" ) )
    version.scan( /\A.*/ ).first
  rescue 
    raise "Error: The Unimatrix SDK VERSION file is missing or invalid."
    exit( 1 )
  end
end
