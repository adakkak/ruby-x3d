# See ISO-IEC-19775-X3D Abstract specification part 1 in
# section 5 (field type reference)
module X3DLib
    $RAND = 10000000000

    def SFBool(s = "FALSE")
        if not ["TRUE", "FALSE"].include? s
            raise SyntaxError, 
                "SFBool input must either be TRUE or FALSE got #{s}",
                caller
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
            raise TypeError,
                "MFBool input must be a String or an Array got #{s}",
                caller
        end

        # Check to see if each value in MFBool is either 
        # TRUE or FALSE
        new_s.each { |boolean|
            if not ["TRUE", "FALSE"].include? boolean
                raise SyntaxError,
                    "MFBool values is not TRUE or FALSE got #{s}",
                    caller
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
            raise TypeError,
                "SFColor input must be a String or an Array got #{color}",
                caller
        end

        if new_color.length != 3:
            raise SyntaxError,
                "SFColor input must be a triplet R G B got #{color}",
                caller
        end

        new_color.each { |color|
            if color > 1.0 or color < 0.0
                raise RangeError,
                    "SFColor values must be between 1.0 and 0.0 got #{color}",
                    caller 
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
            raise TypeError,
                "MFColor input must be a String or an Array got #{colors}",
                caller
        end

        if new_colors.length % 3 != 0
            raise RangeError,
                "MFColor input must be zero or more RGB triples got #{colors}",
                caller
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
            raise TypeError,
                "SFColor input must be a String or an Array got #{color}",
                caller
        end

        if new_color.length != 4:
            raise SyntaxError,
                "SFColorRGBA input must be of the form R G B A got #{color}",
                caller
        end

        new_color.each { |color|
            if color > 1.0 or color < 0.0
                raise RangeError,
                    "SFColorRGBA must be between 1.0 and 0.0 got #{color}",
                    caller
            end
        }

        # convert everything to floating points
        new_color = new_color.map{|color| color.to_f}

        return new_color.join(" ")
    end

    def MFColorRGBA(colors)
        if colors.class == Array
            new_colors = colors
        elsif colors.class == String
            split_char = colors.include?(",") ? ", " : " "
            new_colors = colors.split(split_char)
        else
            raise TypeError,
                "MFColor input must be a String or an Array got #{colors} (#{colors.class})",
                caller
        end

        if new_colors.length % 4 != 0
            raise SyntaxError,
                "MFColorRGBA input must contain zero or more RGBA values got #{new_colors.length}",
                caller
        end
        
        mfcolorrgba = []
        
        (new_colors.length / 4).times do |index|
            mfcolor << SFColorRGBA(new_colors[3*index, 3*(index+1)]) 
        end

        return mfcolorrgba.join(" ")
    end

    def SFFloat(float = 0.0)
        if float.class == String
            if float.to_f == 0.0 and float != "0.0" and float != "0"
                raise TypeError,
                    "SFFloat must be a floating point number. got #{float} (#{float.class})",
                    caller
            end
            new_float = float.to_f
        elsif float.class == Fixnum
            new_float = float.to_f
        elsif float.class == Float
            new_float = float.to_f
        else
            raise TypeError,
                "SFFloat must be a floating point number. got #{float} (#{float.class})",
                caller
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
            raise TypeError, 
                "MFFloat input must be a String or an Array got #{s} (#{s.class})",
                caller
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

    def SFRotation(vec)
        if vec.class == String
            split_char = vec.include?(",") ? ", " : " "
            new_vec = vec.split(split_char)
        elsif vec.class == Array
            new_vec = vec
        else
            raise TypeError, "SFRotation input must be an Array or String got #{vec}", caller
        end
        
        if new_vec.length != 4
            raise RangeError,
                "SFRotation length must be equal to 4, got #{vec} of size #{new_vec.length}",
                caller
        end

        return_vec = []
        new_vec.each{ |v|
            return_vec << SFFloat(v)
        }

        return return_vec.join(" ")
    end

    def MFRotation(*args)
        raise "Not Implemented"
    end

    def SFString(string)
#         return  '"' + string + '"'  # put quotes around the string
        return  string               # while the above is more correct,
        # xml builder gets confused because of it.  It should be OK so long as
        # there is no spaces in the file names
    end

    def MFString(strings)
        return_strings = []
        strings.each{|string| return_strings << SFString(string)}
#         return "'" + return_strings.join(" ") + "'"
        return return_strings.join(" ")
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
            raise TypeError, "SFVec3D input must be an Array or String got #{vec}", caller
        end
        
        if new_vec.length != 3
            raise RangeError,
                "SFVec3D length must be equal to 3, got #{vec} of size #{new_vec.length}",
                caller
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
