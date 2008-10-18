require 'buildings/houses'

class Buildings
    attr_accessor :houses

    def initialize
        # import all the house classes available
        @houses = []
        House.constants.each{ |const| 
            evaled_const = eval("House::" + const)
            @houses << evaled_const if evaled_const.is_a? Class
        }
    end
end


# b = Buildings.new
# p b.houses
