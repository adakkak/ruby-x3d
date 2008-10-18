require '../../lib/X3D'


module House
    class BasicHouse
        attr_accessor :roof_slope

        def initialize(args={})
            @size = args[:size] || [25.0, 25.0, 25.0]
            @dim_x = args[:dim_x] || args[:size][0] || 35.0
            @dim_y = args[:dim_y] || args[:size][1] || 25.0
            @dim_z = args[:dim_z] || args[:size][2] || 25.0
            @roof_slope = args[:root_slope] || 4.0/5.0
        end

        def generate_house
            cross_section = "0.0 0.0, #{@dim_x} 0.0, #{@dim_x} #{@roof_slope*@dim_y},
                            #{@dim_x/2.0} #{@dim_y}, 0.0 #{@roof_slope*@dim_y}, 0.0 0.0"
            spine = "0.0 0.0 0.0, 0.0 0.0 #{-@dim_z}"
            ex = Extrusion.new :is_solid=>"false"
            ex.add_cross_section cross_section
            ex.add_spine spine
            
            app = Appearance.new
            material = Material.new
            shape = Shape.new

            app.add_material material
            shape.add_appearance app
            shape.add_geometry ex

            @house = shape
        end

        def to_xml
            if @house.nil?
                generate_house
            end
            @house.to_xml
        end

        alias to_s to_xml
        alias generate generate_house
    end

    class HouseWGarage
        def initialize(args={})
            @size = args[:size] || [35.0, 25.0, 25.0]
            @dim_x = args[:dim_x] || args[:size][0] || 35.0
            @dim_y = args[:dim_y] || args[:size][1] || 25.0
            @dim_z = args[:dim_z] || args[:size][2] || 25.0

            @garage_disconnected = args[:garage_disconnected] || false
        end

        def generate_house
            # dim_x is rescaled to make room for a garage
            @main_house = BasicHouse.new :size=>[0.6*@dim_x, @dim_y, @dim_z]
            garage = generate_garage
            connector = generate_connector unless @garage_disconnected

            @house = Group.new
            @house.add_node @main_house
            @house.add_node connector unless @garage_disconnected
            @house.add_node garage
        end

        def generate_garage
            garage = Transform.new
            garage.move_to [0.8*@dim_x, 0, -0.5*@dim_z]
            garage.add_shape BasicHouse.new :size=>[0.4*@dim_x, 0.5*@dim_y, 0.5*@dim_z]
            
            return garage
        end

        def generate_connector
            # the connector (or whatever it's called in architecture)
            # is the section that connects the main house to the garage, 
            # which happens to be in a separate position in this model
            connector = Transform.new

            connector_shape = Shape.new
            connector_app = Appearance.new
            connector_material = Material.new
            connector_app.add_material connector_material

            connector_geometry = Box.new :size=>[0.2*@dim_x, 0.5*@main_house.roof_slope*@dim_y, 0.5*@dim_z]

            connector_shape.add_appearance connector_app
            connector_shape.add_geometry connector_geometry

            connector.add_shape connector_shape
            connector.move_to [0.7*@dim_x, 0.25*@main_house.roof_slope*@dim_y, -0.75*@dim_z]

            return connector
        end

        def to_xml
            if @house.nil?
                generate_house
            end
            t = Transform.new
            t.scale = [0.8, 0.8, 0.8]
            t.add_node @house

            t.to_xml
        end

        alias to_s to_xml
        alias generate generate_house
    end

    class FancyHouse
        def initialize(args={})
            @size = args[:size] || [35.0, 25.0, 25.0]

            @dim_x = args[:dim_x] || args[:size][0] || 35.0
            @dim_y = args[:dim_y] || args[:size][1] || 25.0
            @dim_z = args[:dim_z] || args[:size][2] || 25.0

        end

        def generate_house
            # dim_x is rescaled to make room for a garage
            @main_house = BasicHouse.new :size=>[0.6*@dim_x, @dim_y, @dim_z]
            garage = generate_garage

            @house = Group.new
            @house.add_node @main_house
            @house.add_node garage
        end

        def generate_garage
            roof_slope = @main_house.roof_slope
            cross_section = "0.0 0.0,
                             #{0.4*@dim_x} 0.0,
                             #{0.4*@dim_x} #{0.5*roof_slope*@dim_y}, 
                             0.0 #{roof_slope*@dim_y},
                             0.0 0.0"
            spine = "0.0 0.0 0.0, 0.0 0.0 #{-@dim_z}"
            ex = Extrusion.new :is_solid=>"false"
            ex.add_cross_section cross_section
            ex.add_spine spine
            
            app = Appearance.new
            material = Material.new
            shape = Shape.new

            app.add_material material
            shape.add_appearance app
            shape.add_geometry ex

            transform = Transform.new
            transform.add_shape shape
            transform.move_to [0.6*@dim_x, 0, 0]

            return transform
        end

        def to_xml
            if @house.nil?
                generate_house
            end
            @house.to_xml
        end

        alias to_s to_xml
        alias generate generate_house
    end
end

# x = X3D.new
# h = House::BasicHouse.new :size=>[0.4,0.3,0.3]
# t = Transform.new
# t.add_node h
# t.move_to [-0.5, 0.0 ,0.0]
# x.add_node t
# h = House::FancyHouse.new :size=>[0.4,0.3,0.3]
# x.add_node h
# puts x.to_xml
