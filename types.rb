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
            new_color = color.split(split_char).map{|x| x.to_f}
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
        
        mfcolor = []
        
        (new_colors.length / 3).times do |index|
            mfcolor << SFColor(new_colors[3*index, 3*(index+1)]) 
        end

        return mfcolor.join(" ")
    end

    def SFColorRGBA(color)
        if color.class == Array
            new_color = color
        elsif color.class == String
            split_char = color.include?(",") ? ", " : " "
            new_color = color.split(split_char)
        else
            raise "SFColor input must be a String or an Array"
        end

        if new_color.length != 4:
            raise "SFColorRGBA input must be of the form R G B A"
        end

        new_color.each { |color|
            if color > 1.0 or color < 0.0
                raise "SFColorRGBA #{color} must be between 1.0 and 0.0" 
            end
        }

        # convert everything to floating points
        new_color = new_color.map{|color| color.to_f}

        return new_color.join(" ")
    end

    def MFColorRGBA(*args)
        if colors.class == Array
            new_colors = colors
        elsif colors.class == String
            split_char = colors.include?(",") ? ", " : " "
            new_colors = colors.split(split_char)
        else
            raise "MFColor input must be a String or an Array"
        end

        if new_colors.length % 4 != 0
            raise "MFColorRGBA input must contain zero or more RGBA values"
        end
        
        mfcolorrgba = []
        
        (new_colors.length / 4).times do |index|
            mfcolor << SFColorRGBA(new_colors[3*index, 3*(index+1)]) 
        end

        return mfcolorrgba.join(" ")
    end

    def SFFloat(float = 0.0)
        if float.class == String
            if float.to_f == 0.0 and float != "0.0"
                raise "SFFloat must be a floating point number. got #{float}"
            end
            new_float = float.to_f
        elsif float.class == Fixnum
            new_float = float.to_f
        elsif float.class == Float
            new_float = float.to_f
        else
            raise "SFFloat must be a floating point number. got #{float}"
        end

        return new_float.to_s
    end

    def MFFloat(floats = [])
        if floats.class == Array
            new_floats = floats 
        elsif floats.class == String
            split_char = floats.include?(",") ? ", " : " "
            new_floats = floats.split(split_char)
        else
            raise "MFFloat input must be a String or an Array"
        end

        mffloats = []
        new_floats.each { |float|
            mffloats << SFFloat(float)
        }

        return mffloats.join(" ")
    end

    def SFImage(*args)
        raise "Not Implemented"
    end

    def MFImage(*args)
        raise "Not Implemented"
    end

    def SFInt32(*args)
        raise "Not Implemented"
    end

    def MFInt32(*args)
        raise "Not Implemented"
    end

    def SFNode(*args)
        raise "Not Implemented"
    end

    def MFNode(*args)
        raise "Not Implemented"
    end

    def SFRotation(*args)
        raise "Not Implemented"
    end

    def MFRotation(*args)
        raise "Not Implemented"
    end

    def SFString(*args)
        raise "Not Implemented"
    end

    def MFString(*args)
        raise "Not Implemented"
    end

    def SFTime(*args)
        raise "Not Implemented"
    end

    def MFTime(*args)
        raise "Not Implemented"
    end

    def SFVec2d(*args)
        raise "Not Implemented"
    end

    def MFVec2d(*args)
        raise "Not Implemented"
    end

    def SFVec2f(*args)
        raise "Not Implemented"
    end

    def MFVec2f(*args)
        raise "Not Implemented"
    end

    def SFVec3f(vec)
        if vec.class == String
            split_char = vec.include?(",") ? ", " : " "
            new_vec = vec.split(split_char)
        elsif vec.class == Array
            new_vec = vec
        else
            raise "SFVec3D input must be an Array or String"
        end
        
        if new_vec.length != 3
            raise "SFVec3D length must be equal to 3, got #{vec} of size #{new_vec.length}"
        end

        return_vec = []
        new_vec.each{ |v|
            return_vec << SFFloat(v)
        }

        return return_vec.join(" ")
    end

    def MFVec3f(*args)
        raise "Not Implemented"
    end

    alias SFDouble SFFloat
    alias MFDouble MFFloat

    alias SFVec3d SFVec3f
    alias MFVec3d MFVec3f
end
