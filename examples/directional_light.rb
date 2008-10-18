require '../lib/X3D'

scene = X3D.new

light1 = DirectionalLight.new :color=>[1.0, 0.2, 0.2],
                              :direction=>[1, -2.0, 0.0]

light2 = DirectionalLight.new :color=>[1.0, 1.0, 1.0],
                              :direction=>[-1.0, 2.0, 0.0]

cube_geometry = Box.new :size=>[1, 1, 1]
cube_appearance = Appearance.new 
cube_material = Material.new :color=> [0.2, 0.2, 0.9], :diffuse_color=>[0.3, 0.7, 0.3]
cube_appearance.add_material cube_material

cube = Shape.new :appearance => cube_appearance, :geometry => cube_geometry

scene.add_node light1
scene.add_node light2
scene.add_node cube

puts scene
