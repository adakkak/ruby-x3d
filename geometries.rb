require 'rubygems'
require 'builder'
require 'types'

class Box
    include Types

    attr_accessor :def, :size, :is_solid

    def initialize(name, size="2 2 2", is_solid="TRUE")
        @def = name
        @size = SFVec3f(size)
        @is_solid = SFBool(is_solid)
    end

    def size=(size)
        @size = SFVec3f(size)
    end

    def is_solid=(is_solid)
        @is_solid = SFBool(is_solid)
    end

    def to_xml
        xml = Builder::XmlMarkup.new(:indent => 2)
        xml.Box(:def => @def, :size => @size, :solid => @is_solid) 
        xml.target!
    end

    alias to_s to_xml
end

class Cylinder
    include Types

    attr_accessor :def, :radius, :height, :has_bottom, :has_side
    attr_accessor :has_top, :is_solid

    def initialize(name, radius=1, height=2, has_bottom="TRUE",
                   has_side="TRUE", has_top = "TRUE", is_solid="TRUE")
        @def = name
        @radius = SFFloat(radius)
        @height = SFFloat(height)
        @has_bottom = SFBool(has_bottom)
        @has_top = SFBool(has_top)
        @has_side = SFBool(has_side)
        @is_solid = SFBool(is_solid)
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
        xml.Cylinder(:def => @def, 
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
    include Types

    attr_accessor :def, :bottomRadius, :height, :has_bottom, :has_side
    attr_accessor :is_solid

    def initialize(name, bottom_radius=1, height=2, has_bottom="TRUE",
                   has_side="TRUE", is_solid="TRUE")
        @def = name
        @bottom_radius = SFFloat(bottom_radius)
        @height = SFFloat(height)
        @has_bottom = SFBool(has_bottom)
        @has_side = SFBool(has_side)
        @is_solid = SFBool(is_solid)
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
        xml.Cone(:def => @def, 
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
    include Types
    
    attr_accessor :def, :radius, :is_solid

    def initialize(name, radius=1, is_solid="TRUE")
        @def = name
        @radius = SFFloat(radius)
        @is_solid = SFBool(is_solid)
    end

    def radius=(radius)
        @radius = SFVec3f(radius)
    end


    def is_solid=(is_solid)
        @is_solid = SFBool(is_solid)
    end

    def to_xml
        xml = Builder::XmlMarkup.new(:indent => 2)
        xml.Sphere(:def => @def, 
                  :radius => @radius,
                  :solid => @is_solid) 
        xml.target!
    end

    alias to_s to_xml
end
