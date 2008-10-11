require 'rubygems'
require 'builder'
require 'types'

include Types

class Box
    attr_reader :def, :size, :is_solid

    def initialize(args={})
        @def = args[:def] || "Box#{rand(10000)}"
        @size = SFVec3f(args[:size] || "2 2 2") 
        @is_solid = SFBool(args[:is_solid] || "TRUE")
    end

    def size=(size)
        @size = SFVec3f(size)
    end

    def is_solid=(is_solid)
        @is_solid = SFBool(is_solid)
    end

    def to_xml
        xml = Builder::XmlMarkup.new(:indent => 2)
        xml.Box(:DEF => @def, :size => @size, :solid => @is_solid) 
        xml.target!
    end

    alias to_s to_xml
end

class Cylinder
    attr_reader :def, :radius, :height, :has_bottom, :has_side
    attr_reader :has_top, :is_solid

    def initialize(args={})
        @def = args[:def] || "Cylinder#{rand(10000)}"
        @radius = SFFloat(args[:radius] || 1)
        @height = SFFloat(args[:height] || 2)
        @has_bottom = SFBool(args[:has_bottom] || "TRUE")
        @has_top = SFBool(args[:has_top] || "TRUE")
        @has_side = SFBool(args[:has_side] || "TRUE")
        @is_solid = SFBool(args[:is_solid] || "TRUE")
    end

    def radius=(radius)
        @radius = SFVec3f(radius)
    end

    def height=(height)
        @height = SFFloat(height)
    end

    def has_bottom=(has_bottom)
        @has_bottom = SFBool(has_bottom)
    end

    def has_side=(has_side)
        @has_side = SFBool(has_side)
    end

    def has_top=(has_top)
        @has_top = SFBool(has_top)
    end

    def is_solid=(is_solid)
        @is_solid = SFBool(is_solid)
    end

    def to_xml
        xml = Builder::XmlMarkup.new(:indent => 2)
        xml.Cylinder(:DEF => @def, 
                     :radius => @radius,
                     :height => @height,
                     :bottom => @has_bottom,
                     :side => @has_side,
                     :top => @has_top,
                     :solid => @is_solid) 
        xml.target!
    end

    alias to_s to_xml
end

class Cone
    attr_reader :def, :bottomRadius, :height, :has_bottom, :has_side
    attr_reader :is_solid

    def initialize(args={})
        @def = args[:def] || "Cone{rand(10000)}"
        @bottom_radius = SFFloat(args[:bottom_radius] || 1)
        @height = SFFloat(args[:height] || 2)
        @has_bottom = SFBool(args[:has_bottom] || "TRUE")
        @has_side = SFBool(args[:has_side] || "TRUE")
        @is_solid = SFBool(args[:is_solid] || "TRUE")
    end

    def bottom_radius=(bottom_radius)
        @bottom_radius = SFVec3f(bottom_radius)
    end

    def height=(height)
        @height = SFFloat(height)
    end

    def has_bottom=(has_bottom)
        @has_bottom = SFBool(has_bottom)
    end

    def has_side=(has_side)
        @has_side = SFBool(has_side)
    end

    def is_solid=(is_solid)
        @is_solid = SFBool(is_solid)
    end

    def to_xml
        xml = Builder::XmlMarkup.new(:indent => 2)
        xml.Cone(:DEF => @def, 
                 :bottomRadius => @bottomRadius,
                 :height => @height,
                 :bottom => @has_bottom,
                 :side => @has_side,
                 :solid => @is_solid) 
        xml.target!
    end

    alias to_s to_xml
end

class Sphere
    attr_reader :def, :radius, :is_solid

    def initialize(args={})
        @def = args[:def] || "Sphere#{rand(10000)}"
        @radius = SFFloat(args[:radius] || 1)
        @is_solid = SFBool(args[:is_solid] || "TRUE")
    end

    def radius=(radius)
        @radius = SFVec3f(radius)
    end


    def is_solid=(is_solid)
        @is_solid = SFBool(is_solid)
    end

    def to_xml
        xml = Builder::XmlMarkup.new(:indent => 2)
        xml.Sphere(:DEF => @def, 
                  :radius => @radius,
                  :solid => @is_solid) 
        xml.target!
    end

    alias to_s to_xml
end
