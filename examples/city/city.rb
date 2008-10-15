#!/usr/bin/ruby

require '../../lib/X3D'

class Building
    def initialize(dim_x, dim_y, dim_z, pos_x, pos_y)
        @transform = Transform.new :translation => "#{pos_x}, #{pos_y}, 0",
                                   :scale => "#{dim_x}, #{dim_y}, #{dim_z}"

        s = Shape.new
        mat = Material.new :diffuse_color=>get_color( )
#         tex = ImageTexture.new :url=>get_texture( )
        app = Appearance.new :material => mat #, :texture=>tex
        s.add_appearance app
        s.add_geometry Box.new(:size => "1 1 1")
        @transform.add_shape s
    end

    def get_color
        [rand, rand, rand]
    end

    def get_texture
        textures = %w{
           wall/brickvariety_cyc.jpg
           wall/crappypanels_cyc.jpg
           wall/creambrick_cyc.jpg
           wall/greybrick_cyc.jpg
           wall/mosaic01.jpg
           wall/pastelbrick_cyc.jpg
           wall/wallstone.jpg
        }
        textures.shuffle.first
    end
    
    def get_object
        @transform
    end

    def to_xml
        @transform.to_xml
    end

    alias to_s to_xml
end

class CityGen
    def initialize(dims)
        @x3d = X3D.new
        @max_x, @max_y = dims
        @grid = [[:clear] * @max_x] * @max_y
    end
    
    def generate
        generate_streets
        generate_buildings
        generate_x3d
    end

    def generate_streets
        num_of_streets = rand(@max_x)

        if num_of_streets > @max_x/2
            num_of_streets = num_of_streets/2
        end

        num_of_streets.times do |street|
            @grid[rand(@max_y)] = [:street]*@max_x

            r = rand(@max_y)
            @max_y.times do |y|
                @grid[y][street] = :street
            end
        end
    end

    def generate_buildings
        @max_x.times do |x|
            @max_y.times do |y|
                if rand() < 0.05
                    @grid[y][x] = :building
                end
            end
        end
    end

    def generate_x3d
        @max_x.times{|x|
            @max_y.times{|y|
                if @grid[y][x].eql? :building
                    building = Building.new rand, rand, 1, y, x
                    @x3d.add_object building.get_object
                end
            }
        }
        @x3d.to_xml
    end

end

c = CityGen.new([40,40])
puts c.generate
