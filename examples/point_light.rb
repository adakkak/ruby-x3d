require '../lib/X3D'

scene = X3D.new

light1 = PointLight.new :color=>[1.0, 0.2, 0.2],
                        :location=>[1, -2.0, 0.0],
                        :intensity=>0.4,
                        :radius=> 1.0

light2 = PointLight.new :color=>[1.0, 1.0, 1.0],
                        :location=>[-1.0, 2.0, 0.0],
                        :ambient_intensity=>0.3

10.times { |y|
    10.times { |x|
        cube_transform = Transform.new
        cube_geometry = Box.new :size=>[0.5, 0.5, 0.5]
        cube_appearance = Appearance.new 
        cube_material = Material.new :color=> [0.2, 0.2, 0.9], :diffuse_color=>[0.3, 0.7, 0.3]
        cube_appearance.add_material cube_material

        cube = Shape.new :appearance => cube_appearance, :geometry => cube_geometry

        cube_transform.add_shape cube
        cube_transform.move_to [x, y, 0]

        scene.add_node cube_transform
    }
}

scene.add_node light1
scene.add_node light2

puts scene
