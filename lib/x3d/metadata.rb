module X3DLib
    class Metadata
        def initialize
            @meta_data = { }
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

        def to_xml
        end

        alias to_s to_xml
    end
end
