require 'yaml'

class Config
    def initialize(file_name)
        @file_name = file_name
        @config = YAML::load(File.open(@file_name))
    end

    def shape_dir
        default = "data/shapefiles"
        return default unless @config["geo"]
        @config["geo"]["shape_dir"] || "data/shapefiles"
    end

    def max_building_dim
        default = "0.5 0.5 0.5"
        (@config["max_building_dim"] || default).split
    end

    def block_name
        default = "N1670710"
        return default unless @config["geo"]
        @config["geo"]["block_name"] || default
    end

    def block_dir
        default = "data/myblock"
        return default unless @config["geo"]
        @config["geo"]["block_dir"] || default
    end
end
