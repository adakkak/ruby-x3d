#!/usr/bin/ruby

class X3D
    def initialize(*args)
        @scenes = []
        @scene = {}
        @meta_data = { }
        @shapes = []
    end

    def author(author_name)
        @meta_data[:author] = author_name.to_s
    end

    def created_on(date)
        @meta_data[:created_on] = date
    end

    def modified_on(date)
        @meta_data[:modified_on] = date
    end

    def scene
        @scenes << { }
        @scene = @scenes.last
    end
    
    def draw_box(*args)
        @shapes << Box.new(args)
        raise "not implemented"
    end

    def draw_sphere(*args)
        @shapes << Sphere.new(args)
        raise "not implemented"
    end

    def proto_instance(proto)
        @protos << proto
        raise "not implemented"
    end

    def move_to(*args)
        raise "not implemented"
    end
end









x = X3D.new
x.author "Abdulmajed Dakkak"
x.created_on "9/25/2008"
x.modified_on Time.now

Box.new(:scale => [4,4,2], :i => 5)

x.scene
# x.move_to 1,1,1,1

