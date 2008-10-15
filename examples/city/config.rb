require 'yaml'
require 'tile_metadata'

class YamlConfig
    def initialize(file_name=nil)
        if file_name.nil?
            @file_name = "scene.yaml"
        else
            @file_name = file_name
        end
        @config = YAML::load(File.open(@file_name))

        set_defaults
    end
    
    def set_defaults
        @default_shape_dir = "data/shapefiles"
        @default_max_building_dim = [0.5, 0.5, 0.5]
        @default_tile_name = "N1670710"
        @default_tile_dir = "data/tile"
    end

    def shape_dir
        return @default_shape_dir unless @config["geo"]
        @config["geo"]["shape_dir"] || @default_shape_dir
    end

    def max_building_dim
        (@config["max_building_dim"] || @default_max_building_dim).split.map{|x| x.to_f}
    end

    def tile_name
        return @default_tile_name unless @config["geo"]
        @config["geo"]["tile_name"] || @default_tile_name
    end

    def tile_dir
        return @default_tile_dir unless @config["geo"]
        @config["geo"]["tile_dir"] || @default_tile_dir
    end

    def tile_bounding_box
        if @config["bbox"].nil?
            tile_path = File.join(tile_dir( ), tile_name( )+".xml")
            xml = ParseTileMetadata.new(tile_path)

            # returns bounding box of the lat/long form [west, south, east, north]
            return xml.bounding_box        
        else
            bbox = @config["bbox"]
            return [bbox["west"], bbox["south"], bbox["east"],
                bbox["north"]].map{|x| x.to_f}
        end
    end

    def tile_lbounding_box
        if @config["lbbox"].nil?
            tile_path = File.join(tile_dir( ), tile_name( )+".xml")
            xml = ParseTileMetadata.new(tile_path)

            # returns bounding box of the form [left, bottom, right, top]
            return xml.lbounding_box        
        else
            bbox = @config["lbbox"]
            return [bbox["left"], bbox["bottom"], bbox["right"],
                bbox["top"]].map{|x| x.to_f}
        end
    end
end

# c = Config.new
# p c.tile_bounding_box
