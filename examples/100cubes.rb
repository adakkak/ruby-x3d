require '../lib/X3D'

x = X3D.new

100.times { 
    box = Box.new :size=>"0.2 0.2 0.2"
    mat = Material.new :diffuse_color=> [rand, rand, rand]
    app = Appearance.new :material => mat
    s = Shape.new :geometry=>box, :appearance=>app
    t = Transform.new
    t.add_shape s
    t.move_to [rand, rand, rand]
    x.add_object t
}

puts x
