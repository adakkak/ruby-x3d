#!/usr/bin/ruby

require '../../lib/X3D'
require 'building'
require 'config'

class CityGen
    include Building

    def initialize(config)
        @config = Config.new
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
                if rand() < 0.1
                    @grid[y][x] = :building
                end
            end
        end
    end

    def generate_x3d
        @max_x.times do |x|
            @max_y.times do |y|
                if @grid[y][x].eql? :building
                    r = 0.5 #+ rand 
                    house = House.new :dim_x=>r, :dim_y=>1, :dim_z=>r
                    t = Transform.new
                    t.move_to [x, 0, y]
                    t.add_node house
                    @x3d.add_object t
                end
            end
        end
        @x3d.to_xml
    end

end

c = CityGen.new([20, 20])
puts c.generate
