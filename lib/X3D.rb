%w{
    x3d/appearance
    x3d/geometries
    x3d/metadata
    x3d/routes
    x3d/shape
    x3d/text
    x3d/transform
    x3d/x3d
    x3d/types
}.each{ |lib|
    require File.join(File.dirname(__FILE__), "../lib", lib)
}

include X3DLib

