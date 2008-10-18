require 'rubygems'
require 'builder'


module X3DLib
    class Extrusion
        attr_reader :def, :ccw, :convex, :begin_cap, :end_cap
        attr_reader :is_solid, :crease_angle, :cross_section
        attr_reader :spine, :scale, :orientation

        def initialize(args={})
            @def = args[:def] || "Extrusion#{rand($RAND)}"
            @ccw = SFBool(args[:ccw] || "true")
            @convex = SFBool(args[:convex] || "true")
            @begin_cap = SFBool(args[:begin_cap] || "true")
            @end_cap = SFBool(args[:end_cap] || "true")
            @is_solid = SFBool(args[:is_solid] || "true")
            @crease_angle = SFFloat(args[:crease_angle] || 0.0)
            
            @cross_section = MFVec2f(args[:cross_section] || 
                                     "1 1, 1 -1, -1 -1, -1 1, 1 1")
            @spine = MFVec3f(args[:spine] || "0 0 0, 0 1 0")
            @scale = MFVec2f(args[:scale] || "1 1")
            @orientation = MFRotation(args[:rotation] || "0 0 1 0")
        end

        def ccw=(ccw)
            @ccw = SFBool(ccw)
        end

        def convex=(convex)
            @convex = SFBool(convex)
        end

        def begin_cap=(begin_cap)
            @begin_cap = SFBool(begin_cap)
        end

        def end_cap=(end_cap)
            @end_cap = SFBool(end_cap)
        end

        def is_solid=(is_solid)
            @is_solid = SFBool(is_solid)
        end

        def crease_angle=(crease_angle)
            @crease_angle = SFBool(crease_angle)
        end

        def cross_section=(cross_section)
            @cross_section = MFVec2f(cross_section)
        end

        alias add_cross_section cross_section=

        def spine=(spine)
            @spine = MFVec3f(spine)
        end

        alias add_spine spine=

        def scale=(scale)
            @scale = MFVec2f(scale)
        end

        alias add_scale scale=

        def orientation=(orientation)
            @orientation = MFRotation(orientation)
        end

        alias add_orientation orientation=

        def to_xml
            xml = Builder::XmlMarkup.new(:indent => 2)
            xml.Extrusion(:DEF => @def,
                          :ccw => @ccw,
                          :convex => @convex,
                          :beginCap => @begin_cap,
                          :endCap => @end_cap,
                          :solid => @is_solid,
                          :creaseAngle => @crease_angle,
                          :crossSection => @cross_section,
                          :spine => @spine,
                          :scale => @scale,
                          :orientation => @orientation
                         )
            xml.target!
        end

        alias to_s to_xml
    end
end
