require 'rubygems'
require 'builder'
require '../../lib/X3D'

$RAND = 1000000000000000

module Building
    class House
        def initialize(args={})
            @dim_x = args[:dim_x] || 0.5
            @dim_y = args[:dim_y] || 0.5
            @dim_z = args[:dim_z] || 0.5

            @pos_x = args[:pos_x] || 0
            @pos_y = args[:pos_y] || 0
            @pos_z = args[:pos_z] || 0

            generate
        end

        def generate
            generate_ground
            generate_walls
            generate_windows
            generate_door
            generate_roof
        end

        def generate_ground
            @ground = Group.new :Def=>"Ground#{rand($RAND)}"
            a = Appearance.new
            m = Material.new :diffuse_color=>"0.01 0.9 0.2"
            a.add_material m

            object = Box.new :size=>[2*@dim_x, @dim_y/4.0, 2*@dim_z]

            t = Transform.new
            s = Shape.new
            s.add_appearance a
            s.add_geometry object
            t.add_shape s
            t.move_to [0, -@dim_y/2, 0]

            @ground.add_node t
        end

        def generate_walls
            @walls = Group.new :def=>"Walls#{rand($RAND)}"

            #generate some support beams
            [[1,1], [1,-1], [-1,-1], [-1,1]].each { |p, q|
                support = Shape.new
                a = Appearance.new
                m = Material.new       # should be marble in the future
                a.add_material m

                support_beam = Cylinder.new :height=>@dim_y, :radius=>@dim_x/4.0

                support.add_appearance a
                support.add_geometry support_beam

                t = Transform.new
                t.add_shape support
                t.move_to [p*@dim_x/2, 0, q*@dim_z/2]

                @walls.add_node t
            }

            # generate the walls
            t = Transform.new

            a = Appearance.new
            m = Material.new :diffuse_color=>[rand, rand, rand]
            a.add_material m

            t = Transform.new
            s = Shape.new
            s.add_appearance a
            s.add_geometry(Box.new :size=>[@dim_x, @dim_y, @dim_z])
            t.add_shape s

            @walls.add_node t
        end

        def generate_windows
            max_num_of_windows = 5
            num_of_windows = rand(max_num_of_windows - 2) + 2

            @windows = Group.new :def=>"Windows#{rand($RAND)}"

            num_of_windows.times{ |x|
                a = Appearance.new
                m = Material.new :diffuse_color=>"1.0 0.8 #{rand}"
                a.add_material m

                # place window on the boundary
                box = Box.new :size=>[@dim_x/4.0, @dim_y/4.0, @dim_z/8.0]
                
                s = Shape.new
                s.add_appearance a
                s.add_geometry box

                t = Transform.new
                t.add_shape s
                t.move_to [0.5*@dim_x*(rand - 0.5), 0.5*@dim_y*(rand - 0.5), @dim_z/2.0]

                @windows.add_node t
            }
        end

        def generate_door
            @door = Group.new :def=>"Door#{rand($RAND)}"
        end

        def generate_roof
            @roof = Group.new :def=>"Roof#{rand($RAND)}"
        end

        def to_xml
            house = Group.new :def=>"House#{rand($RAND)}"
            house.add_node @ground
            house.add_node @walls
            house.add_node @windows
            house.add_node @door
            house.add_node @roof

            house.to_xml
        end

        alias to_s to_xml
    end
end
