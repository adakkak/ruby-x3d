require 'rubygems'
require 'geo_ruby'

include GeoRuby::Shp4r

in_shpfile = ShpFile.open('sdiv_lot')
out_shpfile = ShpFile.create('out', ShpType::POINT, in_shpfile.fields)

t = out_shpfile.transaction
in_shpfile.each_record do |shape|
    geom = shape.geometry #a GeoRuby SimpleFeature
    if geom.x > 1670000.000060 and geom.x < 1675000.00006 and
       geom.y > 710000.000049 and geom.y < 715000.000049
        t.add shape
    end
end

t.commit
