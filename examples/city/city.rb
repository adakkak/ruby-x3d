#!/usr/bin/ruby

require '../../lib/X3D'
require 'building'
require 'config'
require 'shapefile.rb'

class CityGen
    include Building

    def initialize(config_file_name=nil)
        @config = YamlConfig.new config_file_name
        
        # get the maximum buildings dimensions
        @max_bld_dim_x, @max_bld_dim_y, @max_bld_dim_z = @config.max_building_dim

        # get the maximum coordinates
        @bb_left, @bb_bottom, @bb_right, @bb_top = @config.tile_lbounding_box

        # get the shape file
        shp_file_name = File.join(@config.shape_dir, "sdiv_lot")
        @shp_file = ReadShp.new shp_file_name, @config.tile_lbounding_box

        @x3d = X3D.new
    end

    def generate_ground
       left = 1670000.000060
       bottom = 710000.000049
       right = 1675000
       top = 715000.000049

       t = Transform.new
       s = Shape.new
       a = Appearance.new
       texture = ImageTexture.new :url=>File.join(@config.tile_dir,
                                                  @config.tile_name+"_TIF",
                                                  @config.tile_name.downcase + ".png"
                                                 )
       a.add_material Material.new :diffuse_color=>"0.1 0.1 0.8"
       a.add_texture texture
       s.add_appearance a
       box = Box.new :size=>[(right - left)*(@max_bld_dim_x**2),
                             0.01,
                             (top - bottom)*(@max_bld_dim_z**2)]
       s.add_geometry box

       t.move_to [(@bb_right - left)/(right - left), -0.01,
                  (@bb_top - bottom)/(top - bottom)]

       t.add_object s

       return t
    end
    
    def generate_x3d
        
        while @shp_file.next_record?
            house = House.new :dim_x=>@max_bld_dim_x, :dim_y=>@max_bld_dim_y, :dim_z=>@max_bld_dim_z
            t = Transform.new
            pos = @shp_file.next_record
            t.move_to [(pos[0] - @bb_left)/(@bb_right - @bb_left), 0,
                       (pos[1] - @bb_bottom)/(@bb_top - @bb_bottom)]
            t.add_node house
            @x3d.add_object t
        end

        ground = generate_ground
        @x3d.add_object ground

        @x3d.to_xml
    end

end

c = CityGen.new
puts c.generate_x3d
