require '../lib/X3D'

scene = X3D.new

collision_node = Collision.new
cube = Shape.new
cube_geometry = Box.new
cube_appearance = Appearance.new
cube_material = Material.new :diffuse_color=>[0.1, 0.1, 0.8]

cube_appearance.add_material cube_material

cube.add_geometry cube_geometry
cube.add_appearance cube_appearance

collision_node.add_child cube

scene.add_node collision_node

puts scene
