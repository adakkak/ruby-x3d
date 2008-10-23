require 'rubygems'
require 'builder'

module X3DLib
    # this module currently does not expose all the options that 
    # are available within the collision node
    class Collision
        attr_reader :def, :is_enabled, :is_active, :nodes

        def initialize(args={})
            @def = args[:def] || "Collision#{rand($RAND)}"
            @is_enabled = SFBool(args[:is_enabled] || "TRUE")
            @is_active = SFBool(args[:is_active] || "TRUE")
            @nodes = args[:nodes] || args[:children] || []
        end

        def add_node(node)
            @nodes << node
        end

        alias add_child add_node
        alias add_object add_node
        alias add_transform add_node

        def to_xml
            xml = Builder::XmlMarkup.new(:indent => 2)
            xml.Collision(:DEF => @def) { |tag|
                                    @nodes.each{ |node|
                                        tag << node.to_xml
                                    }
            }
            xml.target!
        end

        alias to_s to_xml
    end
end

# c = X3DLib::Collision.new
# s = X3DLib::Shape.new
# c.add_child s
# puts c
