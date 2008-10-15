#!/usr/bin/ruby

require 'net/http'
require 'rexml/document'

class ParseTileMetadata
    def initialize(file_name)
        file = File.new file_name
        @doc = REXML::Document.new(file)
    end

    def bounding_box
        return [west_bound(), south_bound(), east_bound(), north_bound()]
    end

    def lbounding_box
        return [left_bound(), bottom_bound(), right_bound(), top_bound()]
    end

    def get_bound(direction)
        if @bbox.nil?
            @bbox_element = @doc.root.elements["idinfo/spdom/bounding"]
        end

        @bbox_element.elements["#{direction}bc"].text.to_f
    end

    def get_lbound(direction)
        if @bbox.nil?
            @bbox_element = @doc.root.elements["idinfo/spdom/lboundng"]
        end

        @bbox_element.elements["#{direction}bc"].text.to_f
    end

    def west_bound
        get_bound("west") 
    end

    def east_bound
        get_bound("east") 
    end

    def north_bound
        get_bound("north") 
    end

    def south_bound
        get_bound("south") 
    end

    def left_bound
        get_lbound("left") 
    end

    def right_bound
        get_lbound("right") 
    end

    def bottom_bound
        get_lbound("bottom") 
    end

    def top_bound
        get_lbound("top") 
    end
end

# See http://wiki.openstreetmap.org/index.php/Osmxapi
class OpenStreetMap
    def initialize
        @base_url = "http://xapi.openstreetmap.org/api/0.5/"
    end

    def bounding_box(file)
        @bbox = ParseXMLMetadata.new(file).bounding_box
        return @bbox
    end

    def fetch_data(url)
        resp = Net::HTTP.get_response(URI.parse(url))
        data = resp.body
        return data
    end

    def osm
        if @bbox.nil?
            raise "ERROR: Need to defined the bounding box before calling this method."
        end

        url = @base_url + "map?bbox=#{@bbox.join(",")}"
        return fetch_data(url)
    end

    def nodes(*nodes)
        url = @base_url + ""
    end
end

# c = OpenStreetMap.new
# c.bounding_box("x.xml")
# x = File.new("map.osm", "w")
# x.write(c.osm)
# x.close
