require 'rubygems'
require 'builder'
require 'types'

class Material
    include Types

    attr_accessor :def, :ambient_intensity, :diffuse_color
    attr_accessor :emissive_color, :shininess, :specular_color
    attr_accessor :transparency

    def initialize(name, ambient_intensity=0.2, diffuse_color="0.8 0.8 0.8",
                   emissive_color="0 0 0", shininess=0.2, specular_color="0 0 0",
                   transparency=0.0)
        @def = name
        @ambient_intensity = SFFloat(ambient_intensity)
        @diffuse_color = SFColor(diffuse_color)
        @emissive_color = SFColor(emissive_color)
        @shininess = SFFloat(shininess)
        @specular_color = SFColor(specular_color)
        @transparency = SFFloat(transparency)
    end

    def ambient_intensity=(ambient_intensity)
        @ambient_intensity = SFVec3f(ambient_intensity)
    end

    def diffuse_color=(diffuse_color)
        @diffuse_color = SFColor(diffuse_color)
    end

    def emissive_color=(emissive_color)
        @emissive_color = SFColor(emissive_color)
    end

    def shininess=(shininess)
        @shininess = SFFloat(shininess)
    end

    def specular_color=(specular_color)
        @specular_color = SFColor(specular_color)
    end

    def transparency=(transparency)
        @transparency = SFFloat(transparency)
    end


    def to_xml
        xml = Builder::XmlMarkup.new(:indent => 2)
        xml.Material(:def => @def,
                     :ambientIntensity => @ambient_intensity,
                     :diffuseColor => @diffuse_color,
                     :emissiveColor => @emissive_color,
                     :shininess => @shininess,
                     :specularColor => @specular_color,
                     :transparency => @transparency
                    )
        xml.target!
    end

    alias to_s to_xml
end
