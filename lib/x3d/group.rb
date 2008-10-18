require 'rubygems'
require 'builder'

module X3DLib
    class Group
        def initialize(args={})
            @def = args[:def] || "Group#{rand($RAND)}"
            @objects = []
        end

        def add_object(object)
            @objects << object
        end

        alias add_node add_object

        def to_xml
            xml = Builder::XmlMarkup.new(:indent=>2)

            xml.Group(:DEF=>@def){ |tag|
                @objects.each{ |object|
                    tag << object.to_xml
                }
            }
            xml.target!
        end

        alias to_s to_xml
    end
end
