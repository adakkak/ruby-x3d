require '../lib/X3D'

=begin 
Uses lidar data from Radiohead's album "House of Cards" to recreate one frame
of their music video. This program parses the ascii lidar data and ignores
lines that start with #. Each line in Radiohead's data consists of

    <x_coord>, <y_coord>, <z_coord>, <intensity>

This program thus creates a box at x_coord, y_coord which is z_coord high.
Different shades of gray are then applied based on the intensity value.
=end

FileName = "radiohead_data_frame2.csv"

def get_max
    # I hate to open the file twice, but know of no other way
    max_x, max_y, max_z, max_intensity = 0.0, 0.0, 0.0, 0.0
    File.open(FileName).each { |line|
        unless line.start_with? "#" or line.strip.empty?
            x, y, z, intensity = line.split(",").map{|x| x.to_f}

            max_x = x unless max_x > x
            max_y = y unless max_y > y
            max_z = z.abs unless max_z > z.abs
            max_intensity = intensity unless max_intensity > intensity
        end
    }
    return max_x, max_y, max_z, max_intensity
end

scene = X3D.new

cubes = Group.new

max_x, max_y, max_z, max_intensity = get_max

File.open(FileName).each do |line|
    # ignore lines that start with a hash
    next if line.start_with? "#" or line.strip.empty?

    # parse each line
    x, y, z, intensity = line.split(",").map{|x| x.to_f}

    t = Transform.new

    # move to the x,y position
    t.move_to [x, -y, 0.0]

    shape = Shape.new
    appearance = Appearance.new
    # color the box based on the intensity
    material = Material.new :diffuse_color => [intensity/max_intensity]*3,
                            :ambient_intensity => 0.9,
                            :shininess => 0.5
    appearance.add_material material

    # create a box with height z
    box = Box.new :size=>[1.0, 1.0, z.abs]
    
    shape.add_appearance appearance
    shape.add_geometry box

    t.add_node shape

    cubes.add_node t
end

t = Transform.new

# rescale the scene
t.scale [0.01, 0.01, 0.01]

t.add_node cubes

scene.add_node t

puts scene
