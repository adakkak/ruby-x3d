require 'rubygems'
require 'builder'
require 'types'

class Shape
    include Types
    def initialize(shape_name)
        @def = shape_name
        @appearances = []
        @objects = []
    end
    
    def add_appearance(appearance)
        @appearances = appearance
    end

    def add_object(object)
        @objects << object
    end

    def to_xml
        builder = Builder::XmlMarkup.new(:indent => 2)
        # TODO: use the :use attribute
        builder.shape(:def => @def) { |tag|
            @appearances.each { |appearance| tag << appearance.to_xml}
            @objects.each { |object| tag << object.to_xml}
        }
        builder.target!
    end
end
