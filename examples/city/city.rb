#!/usr/bin/ruby

require '../../lib/X3D'
require 'buildings'
require 'config'
require 'shapefile.rb'

class CityGen

    def initialize(config_file_name=nil)
        @config = YamlConfig.new config_file_name
        
        # get the maximum buildings dimensions
        @max_bld_dim_x, @max_bld_dim_y, @max_bld_dim_z = @config.max_building_dim

        # get the maximum coordinates
        @bb_left, @bb_bottom, @bb_right, @bb_top = @config.tile_lbounding_box

        # get the shape file
        shp_file_name = File.join(@config.shape_dir, "sdiv_lot")
        @shp_file = ReadShp.new shp_file_name, @config.tile_lbounding_box

        @buildings = Buildings.new

        @houses = @buildings.houses

        @x3d = X3D.new
    end

    def generate_ground
       t = Transform.new
       s = Shape.new
       a = Appearance.new
#        texture = ImageTexture.new :url=>File.join(@config.tile_dir,
#                                                   @config.tile_name+"_TIF",
#                                                   @config.tile_name.downcase + ".png"
#                                                  )
       texture = ImageTexture.new :url=>(@config.tile_name.downcase + ".png")
       a.add_material Material.new :diffuse_color=>"0.1 0.1 0.8"
       a.add_texture texture
       s.add_appearance a
       box = Box.new :size=>[@bb_right - @bb_left,  0.01, @bb_top - @bb_bottom]
       s.add_geometry box

       t.move_to [(@bb_right - @bb_left)/2.0, -@max_bld_dim_y/2.0,
                  -(@bb_top-@bb_bottom)/2.0]

       t.add_object s

       return t
    end

    def generate_lights
        lights = Group.new
        lights.add_node PointLight.new :ambient_intensity => 0.3,
                                       :attenuation => [0.9, 0.9, 0.9],
                                       :color => [0.5, 1, 0],
                                       :intensity => 0.9,
                                       :location => [0, 2.3, 1],
                                       :radius => 100
        lights.add_node PointLight.new :ambient_intensity => 0.9,
                                       :attenuation => [1, 1, 1],
                                       :intensity => 0.9,
                                       :location => [1, 1, 1],
                                       :radius => 100
        lights.add_node DirectionalLight.new :ambient_intensity=>0.7,
                                             :color => [1, 0.9, 0.7],
                                             :direction => [0, -1, -0.2]
        lights.add_node DirectionalLight.new :ambient_intensity=>0.7,
                                             :direction => [0, -1, 0]
        lights.add_node DirectionalLight.new :ambient_intensity=>0.7,
                                             :direction => [-1, 0, 0]
        lights.add_node DirectionalLight.new :ambient_intensity=>0.7,
                                             :color => [0.9, 0.5, 0.9],
                                             :direction => [-1, 0, 0]
        lights.add_node DirectionalLight.new :ambient_intensity=>0.7,
                                             :color => [0.5, 0.5, 0.7],
                                             :direction => [1, 0, 0]
        return lights
    end
    
    def generate_x3d
        
        scene = Group.new

        while @shp_file.next_record?
            house = (@houses.shuffle.first).new :dim_x=>@max_bld_dim_x,
                                                :dim_y=>@max_bld_dim_y,
                                                :dim_z=>@max_bld_dim_z
            t = Transform.new
            pos = @shp_file.next_record
            t.move_to [(pos[0] - @bb_left), 0, -(pos[1] - @bb_bottom)]
            t.add_node house
            scene.add_object t
        end

        ground = generate_ground
        scene.add_object ground

        t = Transform.new :scale=>[0.01, 0.01, 0.01]
        t.move_to [-14.0, -3.0, 3.0]

        t.add_node scene

        @x3d.add_object t

        lights = generate_lights
        scene.add_object lights

        @x3d.add_object lights

        @x3d.to_xml
    end

end

c = CityGen.new
puts c.generate_x3d
