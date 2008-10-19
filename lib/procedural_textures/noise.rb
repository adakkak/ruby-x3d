require 'rubygems'
require 'RMagick'

include Magick

module Noise
    class Noise3D
        def initialize
            @G = []
            255.times do 
                @G << nil

                while true
                    xyz = [rand*2 - 1.0, rand*2 - 1.0, rand*2 - 1.0]
                    @G[-1] = normalize(xyz)
                    break if length(@G[-1]) < 1.0
                end
            end

            @P = (1...255).to_a.shuffle
        end


        def length(xyz)
            x, y, z = xyz
            return Math.sqrt(x**2 + y**2 + z**2)
        end

        alias norm length

        def normalize(xyz)
            x, y, z = xyz
            norm = length(xyz)
            
            return [x/norm, y/norm, z/norm]
        end

        def fold(x,y,z)
            n = @P[x % @P.length]
            n = @P[(n + y) % @P.length]
            n = @P[(n + z) % @P.length]
            return n
        end

        def noise(x, y, z)
            cell = [x.floor, y.floor, z.floor]

            sum = 0.0
            [[0,0,0], [0,0,1], [0,1,1], [0,1,0],
             [1,1,0], [1,0,0], [1,0,1], [1,1,1]].each do |corner|
                i, j, k = [cell[0] + corner[0], 
                           cell[1] + corner[1],
                           cell[2] + corner[2]
                          ]
                u, v, w = [x - i, y - j, z - k]

                gradient = @G[fold(i, j, k) % @G.length]  
                sum += omega(u,v,w) * dot(gradient, [u,v,w])
            end
            return [[sum, 1.0].min, -1.0].max
        end

        def dot(vec1, vec2)
            vec1[0]*vec2[0] + vec1[1]*vec2[1] + vec1[2]*vec2[2]
        end

        def omega(u, v, w)
            drop(u) * drop(v) * drop(w)
        end

        def drop(t)
            t = t.abs
            1.0 - t*t*t*(t*(t*6-15)+10)
        end

        def draw(args={})
            size = args[:size] || [256, 256]
            scale = args[:scale] || 32.0
            file_name = args[:file_name] || args[:output_file] || args[:file]
            z = args[:z] || "0.0"

            canvas = Image.new(size[0], size[1])
            gc = Draw.new


            size[0].times{ |x|
                size[1].times{ |y|
                    n = (128*(noise(x/scale, y/scale, z) + 1)).to_i
                    gc.fill("rgb(#{n},#{n},#{n})")
                    gc.point(x,y)
                }
            }
            gc.draw(canvas)

            canvas.write(file_name)
        end
    end

    class Noise2D
        def initialize
            @G = []
            255.times do 
                @G << nil

                while true
                    xy = [rand * 2 - 1.0, rand * 2 - 1.0]
                    @G[-1] = normalize(xy)
                    break if length(@G[-1]) < 1.0
                end
            end

            @P = (1...255).to_a.shuffle
        end


        def length(xy)
            x, y = xy
            return Math.sqrt(x**2 + y**2)
        end

        alias norm length

        def normalize(xy)
            x, y = xy
            norm = length(xy)
            
            return [x/norm, y/norm]
        end

        def fold(x,y)
            n = @P[x % @P.length]
            n = @P[(n + y) % @P.length]
            return n
        end

        def noise(x, y)
            cell = [x.floor, y.floor]

            sum = 0.0
            [[0,0], [0,1], [1,0], [1,1]].each do |corner|
                i, j = [cell[0] + corner[0], cell[1] + corner[1]]
                u, v = [x - i, y - j]

                gradient = @G[fold(i, j) % @G.length]  
                sum += omega(u,v) * dot(gradient, [u,v])
            end
            return [[sum, 1.0].min, -1.0].max
        end

        def dot(vec1, vec2)
            vec1[0]*vec2[0] + vec1[1]*vec2[1]
        end

        def omega(u, v)
            drop(u) * drop(v)
        end

        def drop(t)
            t = t.abs
            1.0 - t*t*t*(t*(t*6-15)+10)
        end

        def draw(args={})
            size = args[:size] || [256, 256]
            scale = args[:scale] || 32.0
            file_name = args[:file_name] || args[:output_file] || args[:file]

            canvas = Image.new(size[0], size[1])
            gc = Draw.new


            size[0].times{ |x|
                size[1].times{ |y|
                    n = (128*(noise(x/scale, y/scale) + 1)).to_i
                    gc.fill("rgb(#{n},#{n},#{n})")
                    gc.point(x,y)
                }
            }
            gc.draw(canvas)

            canvas.write(file_name)
        end
    end
end

10.times do |z|
    n = Noise::Noise3D.new
    n.draw :file=>"noise#{z}.png", :size=>[128,128], :scale=>16.0, :z=>z
    puts "finished #{z}...."
end
