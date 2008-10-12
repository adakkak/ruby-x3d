#!/usr/bin/ruby

%w{x3d shape geometries transform}.each{ |lib|
    require lib
}

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
                if rand() < 0.8
                    @grid[y][x] = :building
                end
            end
        end
    end

    def generate_x3d
        @max_x.times{|x|
            @max_y.times{|y|
                if @grid[y][x].eql? :building
                    t = Transform.new :translation=>[x,y,0],
                                      :scale=>[1 - 0.5*rand(), 1 - 0.5*rand(), rand(3)]
                    s = Shape.new
                    mat = Material.new :diffuse_color=>[0.5, 0.5, 0.5]
                    tex = ImageTexture.new :url=>"./textures/building/wall/mosaic01.jpg"
                    app = Appearance.new :material => mat, :texture=>tex
                    s.add_appearance app
                    s.add_geometry Box.new(:size => "1 1 1")
                    t.add_shape s
                    @x3d.add_object t
                end
            }
        }
        @x3d.to_xml
    end

end

c = CityGen.new([5,5])
puts c.generate
