require 'rubygems'
require 'builder'

module X3DLib
    class LightNode
        attr_reader :def, :ambient_intensity, :color
        attr_reader :direction, :intensity, :on, :global

        def initialize(args={})
            @def = args[:def] || "LightNode#{rand($RAND)}"
            @ambient_intensity = SFFloat(args[:ambient_intensity] || 0.0)
            @color = SFColor(args[:color] || "1 1 1")
            @direction = SFVec3f(args[:direction] || "0 0 -1")
            @intensity = SFFloat(args[:intensity] || 1.0)
            @on = SFBool(args[:on] || "TRUE")
            @global = SFBool(args[:global] || "FALSE")
        end

        def ambient_intensity=(ambient_intensity)
            @ambient_intensity = SFFloat(ambient_intensity)
        end
        
        alias ambient_intensity ambient_intensity=

        def color=(color)
            @color = SFColor(color)
        end
        
        alias color color=

        def direction=(direction)
            @direction = SFVec3f(direction)
        end
        
        alias direction direction=

        def intensity=(intensity)
            @intensity = SFFloat(intensity)
        end
        
        alias intensity intensity=


        def on=(on)
            @on = SFBool(on)
        end
        
        alias on on=


        def global=(global)
            @global = SFBool(global)
        end
        
        alias global global=
    end

    class DirectionalLight < LightNode

        def initialize(args={})
            super(args)
            @def = args[:def] || "DirectionalLight#{rand($RAND)}"
        end

        def to_xml
            xml = Builder::XmlMarkup.new(:indent => 2)
            xml.DirectionalLight(:DEF => @def,
                                 :ambientIntensity => @ambient_intensity,
                                 :color => @color,
                                 :direction => @direction,
                                 :on => @on
                                )
                xml.target!
            xml.target!
        end

        alias to_s to_xml
    end

    class PointLight < LightNode

        attr_reader :attenuation, :location, :radius

        def initialize(args={})
            super(args)
            @def = args[:def] || "DirectionalLight#{rand($RAND)}"
            @attenuation = SFVec3f(args[:attenuation] || [1, 0, 0])
            @location = SFVec3f(args[:location] || [0, 0, -1])
            @radius = SFFloat(args[:radius] || 100.0)
        end

        def attenuation=(attenuation)
            @attenuation = SFVec3f(attenuation)
        end
        
        alias attenuation attenuation=

        def location=(location)
            @location = SFVec3f(location)
        end

        alias location location=

        def radius=(radius)
            @radius = SFFloat(radius)
        end

        alias radius radius=

        def to_xml
            xml = Builder::XmlMarkup.new(:indent => 2)
            xml.PointLight(:DEF => @def,
                           :ambientIntensity => @ambient_intensity,
                           :attenuation => @attenuation,
                           :color => @color,
                           :intensity => @intensity,
                           :location => @location,
                           :on => @on,
                           :radius => @radius
                          )
                xml.target!
            xml.target!
        end

        alias to_s to_xml
    end

    class SpotLight
        def initialize(*args)
            raise "Class not Implemented"
        end
    end
end
