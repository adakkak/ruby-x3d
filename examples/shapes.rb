require '../lib/X3D'

scene = X3D.new

basic_appearance = Appearance.new 
basic_material = Material.new :color=> [0.2, 0.2, 0.9], :diffuse_color=>[0.3, 0.7, 0.3]
basic_appearance.add_material basic_material

# Draw a cube
cube_transform = Transform.new
cube_geometry = Box.new
cube = Shape.new :appearance => basic_appearance, :geometry => cube_geometry

cube_transform.add_shape cube
cube_transform.move_to [-3.0, 0, 0]


# Draw a cone
cone_transform = Transform.new
cone_geometry = Cone.new
cone = Shape.new :appearance => basic_appearance, :geometry => cone_geometry

cone_transform.add_shape cone
cone_transform.move_to [0.0, 0, 0]

# Draw a cylinder
cylinder_transform = Transform.new
cylinder_geometry = Cylinder.new
cylinder = Shape.new :appearance => basic_appearance, :geometry => cylinder_geometry

cylinder_transform.add_shape cylinder
cylinder_transform.move_to [3.0, 0, 0]

# Draw a sphere
sphere_transform = Transform.new
sphere_geometry = Sphere.new
sphere = Shape.new :appearance => basic_appearance, :geometry => sphere_geometry

sphere_transform.add_shape sphere
sphere_transform.move_to [0.0, 3, 0]

# add them to the scene
scene.add_node cube_transform
scene.add_node cone_transform
scene.add_node cylinder_transform
scene.add_node sphere_transform

puts scene
