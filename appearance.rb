require 'rubygems'
require 'builder'
require 'types'

include Types

class Appearance
    attr_reader :def, :material, :texture, :texture_transform

    def initialize(args={})
        @def = args[:def] || "Appearance#{rand(1000)}"
        @material = args[:material]
        @texture = args[:texture]
        @texture_transform = args[:texture_transform]
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
        xml.Appearance(:DEF => @def) { |tag|
            tag << @material.to_xml
            unless @texture.nil?
                tag << @texture.to_xml
                tag << @texture_transform.to_xml unless @texture_transform.nil?
            end
        }
        xml.target!
    end

    alias to_s to_xml
end

class Material
    attr_reader :def, :ambient_intensity, :diffuse_color
    attr_reader :emissive_color, :shininess, :specular_color
    attr_reader :transparency

    def initialize(args={})
        @def = args[:def] || "Material#{rand(1000)}"
        @ambient_intensity = SFFloat(args[:ambient_intensity] || 0.2)
        @diffuse_color = SFColor(args[:diffuse_color] || "0.8 0.8 0.8")
        @emissive_color = SFColor(args[:emissive_color] || "0 0 0")
        @shininess = SFFloat(args[:shininess] || 0.2)
        @specular_color = SFColor(args[:specular_color] || "0 0 0")
        @transparency = SFFloat(args[:transparency] || 0.0)
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
        xml.Material(:DEF => @def,
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

class ImageTexture
    attr_reader :def, :url, :repeat_s, :repeat_t

    def initialize(args={})
        @def = args[:def] || "ImageTexture#{rand(1000)}"
        @urls = args[:urls] || args[:url] || []
        @repeat_s = SFBool(args[:repeat_s] || "TRUE")
        @repeat_t = SFBool(args[:repeat_t] || "TRUE")

        @urls.each{ |url|
            unless file_exists? url
                raise IOError, "File #{url} was not found", caller
            end
        }
    end

    def file_exists?(file)
        return File.file? file
    end

    def add_url(url)
        dontcare = MFString(url)        # check to see if something fails
                                        # it's easier to keep track of an
                                        # array, however.
        @urls << url
    end

    def repeat_s=(repeat_s)
        @repeat_s = repeat_s
    end
    
    def repeat_t=(repeat_t)
        @repeat_t = repeat_t
    end

    def to_xml
        xml = Builder::XmlMarkup.new(:indent => 2)
        xml.ImageTexture(:DEF => @def,
                         :url => MFString(@urls),
                         :repeatS => @repeat_s,
                         :repeatT => @repeat_t
                        )
        xml.target!
    end

    alias to_s to_xml
end

# x = ImageTexture.new("image")
# x.add_url("/home/adakkak/.wallpaper/pic.jpg")
# x.add_url("/usr/share/s.png")
# puts x
