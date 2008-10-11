require 'rubygems'
require 'builder'
require 'types'

class Transform
    include Types

    def initialize(args={})
        @def = args[:def] || "Transform#{rand(10000)}"
        @translation = SFVec3f(args[:translation] || "0 0 0")
        @rotation = SFRotation(args[:rotation] || "0 0 1 0")
        @center = SFVec3f(args[:center] || "0 0 0")
        @scale = SFVec3f(args[:scale] || "1 1 1")
        @scale_orientation = SFRotation(args[:scale_orientation] || "0 0 1 0")
        @shapes = []
    end

    def translation=(translation)
        @translation = SFVec3f(translation)
    end

    def rotation=(rotation)
        @rotation = SFRotation(rotation)
    end

    def center=(center)
        @center = SFVec3f(center)
    end

    def scale=(scale)
        @scale = SFVec3f(scale)
    end

    def scale_orientation=(scale_orientation)
        @scale_orientation = SFRotation(scale_orientation)
    end

    def add_shape(shape)
        @shapes << shape
    end

    def move_to point
        @translation = SFVec3f(point)
    end

    def to_xml
        if @shapes.length.zero?
            puts "WARNING: Transform's Shape node is empty"
        end

        xml = Builder::XmlMarkup.new(:indent => 2)
        xml.Transform(:DEF => @def,
                      :translation => @translation,
                      :rotation => @rotation,
                      :center => @center,
                      :scale => @scale,
                      :scaleOrientation => @scale_orientation
                     ) { |tag|
            @shapes.each{ |shape|
                tag << shape.to_xml
            }
        }
        xml.target!
    end

    alias to_s to_xml
end

# require 'shape'
# require 'appearance'
# t = Transform.new :def=> "my transform", :translation => "1 0 0"
# s = Shape.new :def=> "my shape",
#                     :geometry=>Box.new(:def=>"mybox", :size=>"4 4 4"),
#                     :appearance=>Appearance.new(:def=>"my appearance",
#                                     :material=>Material.new(:def=>"my material",
#                                                             :ambient_intensity=>0.2,
#                                                             :diffuse_color=>"0.1 0.1 0.9"),
#                                     :texture=>ImageTexture.new(:def=>"my texture",
#                                                             :url=>"/home/adakkak/.wallpaper/a.jpg")
#                                                )
# t.add_shape s
# t.move_to "0 9 0"
# puts t
