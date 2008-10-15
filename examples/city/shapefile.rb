require 'rubygems'
require 'geo_ruby'
require 'generator'

include GeoRuby::Shp4r

class ReadShp
    def initialize(shp_file_name, bbox)
        @shpfile = ShpFile.open(shp_file_name)
        @bbox = bbox

        # split them up to make life easier
        @bbox_left = @bbox[0]
        @bbox_bottom = @bbox[1]
        @bbox_right = @bbox[2]
        @bbox_top = @bbox[3]

        create_generator
    end

    def create_generator
        @generator = Generator.new{ |g|
            @shpfile.each_record do |shape|
                geom = shape.geometry #a GeoRuby SimpleFeature
                if geom.x > @bbox_left and geom.x < @bbox_right and
                geom.y > @bbox_bottom and geom.y < @bbox_top
                    g.yield [geom.x.to_f, geom.y.to_f]
                end
            end
        }
    end

    def next
        @generator.next
    end

    alias next_record next

    def next?
        @generator.next?
    end

    alias next_record? next?
end
