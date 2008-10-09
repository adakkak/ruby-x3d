#!/usr/bin/ruby

class CityGen
    def initialize(dims)
        @max_x, @max_y = dims
        @grid = [[:clear] * @max_x] * @max_y
    end
    
    def generate
        generate_streets
        generate_buildings
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

end
