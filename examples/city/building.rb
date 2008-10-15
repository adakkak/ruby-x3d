require 'rubygems'
require 'builder'
require '../../lib/X3D'

module Building
    class House
        def initialize(args={})
            @dim_x = args[:dim_x] || 2
            @dim_y = args[:dim_y] || 2
            @dim_z = args[:dim_z] || 2

            @pos_x = args[:pos_x] || 0
            @pos_y = args[:pos_y] || 0
            @pos_z = args[:pos_z] || 0
        end

        def generate
            generate_ground
            generate_walls
            generate_windows
            generate_door
            generate_roof
        end

        def generate_ground
            a = Appearance.new
            m = Matrerial.new :diffuse_color=>"0.1 0.9 0.2"
            a.add_material m

            object = Box.new :size=>[dim_x+0.5, dim_y+0.5, dim_z+0.5]

            @ground = Transform.new
            @ground.add_appearance a
            @ground.add_object object
        end

        def generate_walls
            @walls = Group.new

            #generate some support beams
            support = Shape.new
            a = Appearance.new
            m = Matrerial.new       # should be marble in the future
            a.add_material m

            support_beam = Cylinder.new :height=>@dim_z

            support.add_appearance a
            support.add_geometry support_beam

            t = Transform.new
            t.add_object support

            @walls.add_node t

            # generate the walls
            t = Transform.new

            a = Appearance.new
            m = Matrerial.new :diffuse_color=>"0.2 0.2 0.9"
            a.add_material m

            t = Transform.new
            s = Shape.new
            s.add_appearance a
            s.add_geometry(Box.new :size=>[dim_x, dim_y, dim_z])
            t.add_object s

            @walls.add_node t
        end

        def generate_windows
            max_num_of_windows = 5
            num_of_windows = rand(max_num_of_windows)

            @windows = Group.new

            num_of_windows.times{ |x|
                a = Appearance.new
                m = Matrerial.new :diffuse_color=>"0.8 0.8 0.9"
                a.add_material m

                # place window on the boundary
                box = Box.new :size=>[dim_x/4, dim_y/4, 0.1]
                
                s = Shape.new
                s.add_appearance a
                s.add_geometry box

                t = Transform.new
                t.move_to [dim_x, dim_y.to_f/max_num_of_windows, dim_z]
                t.add_object s

                @windows.add_node t
            }
        end

        def generate_door
            @door = Group.new
        end

        def generate_roof
            @roof = Group.new
        end

        def to_xml
            house = Group.new
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
