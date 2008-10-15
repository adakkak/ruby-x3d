require 'rubygems'
require 'builder'

module X3DLib
    class Shape
        attr_accessor :def, :appearance, :geometry

        def initialize(args={})
            @def = args[:def] || "Shape#{rand(10000)}"
            @appearance = args[:appearance] || nil
            @geometry = args[:geometry] || nil
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
            xml.Shape(:DEF => @def) { |tag|
                tag << @appearance.to_xml
                tag << @geometry.to_xml
            }
            xml.target!
        end

        alias to_s to_xml
    end

    # s = Shape.new("myShape")
    # a = Appearance.new("myAppearance")
    # a.add_material(ImageTexture.new("my texture","/home/top/adak/jds.jpg"))
    # s.add_appearance(a)
    # s.add_geometry(Box.new("mybox", "2 3 3"))
    # puts s
end
