require 'rubygems'
require 'geo_ruby'

include GeoRuby::Shp4r

in_shpfile = ShpFile.open('streets')

c = 1
in_shpfile.each_record do |shape|
    geom = shape.geometry #a GeoRuby SimpleFeature
    if c < 4000
#         p shape
#         p shape.methods
#     if shape.data["Street"] == "FOTH DRIVE"
        p shape.data["Street"]
        c += 1
    else
        break
    end
end
