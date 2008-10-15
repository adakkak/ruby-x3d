#!/usr/bin/ruby

module X3DLib
    class X3D
        def initialize
            @scenes = []
            @metadata = nil
            @scene = {}
            @objects = []
        end

        def scene
            @scenes << { }
            @scene = @scenes.last
        end
        
        def proto_instance(proto)
            @protos << proto
            raise "not implemented"
        end

        def add_object(object)
            @objects << object
        end

        def to_xml
            require 'rubygems'
            require 'builder'

            xml = Builder::XmlMarkup.new(:indent=>2)

            # generate XML heading
            xml.instruct! :xml, :version=>"1.0", :encoding=>"UTF-8"

            # generate X3D declaration
            dtd = "http://www.web3d.org/specifications/x3d-3.0.dtd"
            std = "ISO//Web3d//DTD X3D 3.0//EN"
            xml.declare! :DOCTYPE, :X3D, :PUBLIC, std, dtd

            # place content
            xml.X3D(:profile=>"Immersize", :version=>"3.0"){ |x3d|
                x3d.head << @metadata.to_xml unless @metadata.nil?
                x3d.Scene { |tag|
                    unless @objects.nil?
                        @objects.each{ |object|
                            tag << object.to_xml
                        }
                    end
                }
            }

            xml.target!
        end

        alias to_s to_xml
    end


    # require 'shape'
    # require 'transform'

    # x = X3D.new
    # m = Metadata.new
    # m.author "Abdulmajed Dakkak"
    # m.created_on "9/25/2008"
    # m.modified_on Time.now

    # s = Shape.new 
    # s.add_geometry Box.new(:def=>"test", :size=>[4,4,3])
    # m = Appearance.new :def=>"my appearance"
    # m.add_material Material.new(:def=>"my material", :ambient_intensity=>0.4, :diffuse_color=>"0.4 0.4 0.2")
    # m.add_texture ImageTexture.new(:def=>"my texture", :url=>"/home/adakkak/.wallpaper/a.jpg")
    # s.add_appearance m

    # t = Transform.new(:def=>"my transform")
    # t.add_shape s
    # x.add_object t

    # puts x.to_xml
    # x.move_to 1,1,1,1
end
