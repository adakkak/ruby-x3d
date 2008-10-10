require 'rubygems'
require 'builder'
require 'types'

%w{material texture}.each{|lib| require lib}

class Appearance
    include Types

    attr_reader :name, :material, :texture, :texture_transform

    def initialize(name, material = nil, texture = nil, texture_transform = nil)
        @def = name
        @material = material
        @texture = texture
        @texture_transform = texture_transform
    end

    def add_material(material)
        @material = material
    end

    def add_texture(texture)
        @texture = texture
    end

    def add_texture_transform(texture_transform)
        @texture_transform = texture_transform
    end

    def to_xml
        if @material.nil? and @texture.nil?
            puts "Might have forgoten to place a material"
        end

        xml = Builder::XmlMarkup.new(:indent => 2)
        xml.Appearance(:def => @def) { |tag|
            tag << @material.to_xml
            if not @texture.nil?
                tag << @texture.to_xml
                tag << @texture_transform.to_xml
            end
        }
        xml.target!
    end

    alias to_s to_xml
end
