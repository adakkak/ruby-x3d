require '../lib/X3D'

scene = X3D.new

scene.add_shape Shape.new :geometry=>Box.new

puts scene
