class Transform
    def initialize( )
        @shapes = []
        @translation = [0, 0, 0]
        @scale = [0, 0, 0]
    end

    def add_shape(shape)
        @shapes << shape
    end
end
