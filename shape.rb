require 'rubygems'
require 'builder'
require 'types'

require 'appearance'
require 'geometries'

class Shape
    include Types
    attr_accessor :def, :appearance, :geometry

    def initialize(name, appearance = nil, geometry = nil)
        @def = name
        @appearance = appearance
        @geometry = geometry
    end
    
    def add_appearance(appearance)
        @appearance = appearance
    end

    def add_geometry(geometry)
        @geometry = geometry
    end

    def to_xml
        if @geometry.nil?
            raise "Shape geometry cannot be nil"
        elsif @appearance.nil?
            raise "Shape appearance cannot be nil"
        end

        xml = Builder::XmlMarkup.new(:indent => 2)
        # TODO: use the :use attribute
        xml.Shape(:def => @def) { |tag|
            tag << @appearance.to_xml
            tag << @geometry.to_xml
        }
        xml.target!
    end

    alias to_s to_xml
end

# s = Shape.new("myShape")
# a = Appearance.new("myAppearance")
# a.add_material(Material.new("my material", 0.1, "0 0 0"))
# s.add_appearance(a)
# s.add_geometry(Box.new("mybox", "2 3 3"))
# puts s
