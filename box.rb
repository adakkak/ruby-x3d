class Box < Shape
    def initialize(args)
        args.each{ |key, value|
            p "#{key}:"
        }
    end
end
