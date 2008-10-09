# See ISO-IEC-19775-X3D Abstract specification part 1 in
# section 5 (field type reference)
module Types
    def SFBool(s = "FALSE")
        if not ["TRUE", "FALSE"].include? s
            raise "SFBool input must either be TRUE or FALSE"
        end

        return s
    end

    def MFBool(s = [])
        if s.class == Array
            new_s = s 
        elsif s.class == String
            split_char = s.include?(",") ? ", " : " "
            new_s = s.split(split_char)
        else
            raise "MFBool input must be a String or an Array"
        end

        # Check to see if each value in MFBool is either 
        # TRUE or FALSE
        new_s.each { |boolean|
            if not ["TRUE", "FALSE"].include? boolean
                raise "MFBool values is not TRUE or FALSE"
            end
        }

        return new_s.join(" ")
    end

    def SFColor(color = "0 0 0")
        if color.class == Array
            new_color = color
        elsif color.class == String
            split_char = color.include?(",") ? ", " : " "
            new_color = color.split(split_char)
        else
            raise "SFColor input must be a String or an Array"
        end

        if new_color.length != 3:
            raise "SFColor input must be a triplet R G B"
        end

        new_color.each { |color|
            if color > 1.0 or color < 0.0
                raise "SFColor #{color} must be between 1.0 and 0.0" 
            end
        }

        # convert everything to floating points
        new_color = new_color.map{|color| color.to_f}

        return new_color.join(" ")
    end

    def MFColor(colors = [])
        if colors.class == Array
            new_colors = colors
        elsif colors.class == String
            split_char = colors.include?(",") ? ", " : " "
            new_colors = colors.split(split_char)
        else
            raise "MFColor input must be a String or an Array"
        end

        if new_colors.length % 3 != 0
            raise "MFColor input must be zero or more RGB triples"
        end
        
        mfcolor = ""
        
        (new_colors.length / 3).times do |index|
            mfcolor += " " + SFColor(new_colors[3*index, 3*(index+1)]) 
        end

        return mfcolor
    end

    def SFColorRGBA
        raise "Not Implemented"
    end

    def MFColorRGBA
        raise "Not Implemented"
    end

    def SFDouble
        raise "Not Implemented"
    end

    def MFDouble
        raise "Not Implemented"
    end

    def SFFloat
        raise "Not Implemented"
    end

    def MFFloat
        raise "Not Implemented"
    end

    def SFImage
        raise "Not Implemented"
    end

    def MFImage
        raise "Not Implemented"
    end

    def SFInt32
        raise "Not Implemented"
    end

    def MFInt32
        raise "Not Implemented"
    end

    def SFNode
        raise "Not Implemented"
    end

    def MFNode
        raise "Not Implemented"
    end

    def SFRotation
        raise "Not Implemented"
    end

    def MFRotation
        raise "Not Implemented"
    end

    def SFString
        raise "Not Implemented"
    end

    def MFString
        raise "Not Implemented"
    end

    def SFTime
        raise "Not Implemented"
    end

    def MFTime
        raise "Not Implemented"
    end

    def SFVec2d
        raise "Not Implemented"
    end

    def MFVec2d
        raise "Not Implemented"
    end

    def SFVec2f
        raise "Not Implemented"
    end

    def MFVec2f
        raise "Not Implemented"
    end

    def SFVec3d
        raise "Not Implemented"
    end

    def MFVec3d
        raise "Not Implemented"
    end

    def SFVec3f
        raise "Not Implemented"
    end

    def MFVec3f
        raise "Not Implemented"
    end
end
