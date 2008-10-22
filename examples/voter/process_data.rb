require 'generator'

class ProcessData
    attr_reader :file_content, :parties

    def initialize(args={})
        @file_name = args[:file_name]
        @parties = {"D" => "Democrat",
                    "E" => "Reform",
                    "L" => "Libertarian",
                    "N" => "Natural Law",
                    "R" => "Republican"
                   }
        @elections = []

        parse_file
    end

    def parse_line(line)
        m = {}
        line = line.split(",").map(&:strip)

        # See Voter_File_Layout.doc
        # We are ignoring the information that we 
        # are not going to use

    #     m[:sos_voter_id] = line[0]
    #     m[:county_number] = line[1]
    #     m[:count_id] = line[2]
    #     m[:last_name] = line[3]
    #     m[:first_name] = line[4]
    #     m[:middle_name] = line[5]
    #     m[:suffix] = line[6]
    #     m[:birth_year] = line[7]
        
    #     m[:registration_date] = line[8]
        m[:party_affiliation] = line[9]

        m[:residential_address] = line[10]
    #     m[:residential_address2] = line[11]
    #     m[:residential_city] = line[12]
    #     m[:residential_state] = line[13]
        m[:residential_zip] = line[14]
    #     m[:residential_zip_ext] = line[15]
    #     m[:residential_country] = line[16]
    #     m[:residential_postal_code] = line[17]

    #     m[:mailing_address] = line[18]
    #     m[:mailing_address_2] = line[19]
    #     m[:mailing_city] = line[20]
    #     m[:mailing_state] = line[21]
    #     m[:mailing_zip] = line[22]
    #     m[:mailing_zip_ext] = line[23]
    #     m[:mailing_country] = line[24]
    #     m[:mainling_postal_code] = line[25]

    #     m[:career_center] = line[26]

    #     m[:city] = line[27]
    #     m[:city_school_district] = line[28]
    #     m[:county_court_district] = line[29]
    #     m[:congressional_district_id] = line[30]
    #     m[:courts_of_appeals_id] = line[31]
    #     m[:education_service_center] = line[32]
    #     m[:exempt_school_district] = line[33]
    #     m[:local_school_district] = line[34]
    #     m[:municipal_court_district] = line[35]
    #     m[:precinct] = line[36]
    #     m[:precinct_code] = line[37]
    #     m[:state_board_of_education_id] = line[38]
    #     m[:state_representitive_district_id] = line[39]
    #     m[:state_senate_district_id] = line[40]
    #     m[:township] = line[41]
    #     m[:village] = line[43]
    #     m[:ward] = line[42]
        m[:voting_record] = line[44...line.length]

        return m
    end

    def parse_file
        first_line = true

        @records = Generator.new{|g|
            File.read(@file_name).each { |line|
                # Skip the first line, which contains the CSV headings
                if first_line.eql? true
                    first_line = false
                    m = parse_line(line)
                    # we are interested in what the election names were
                    @elections = m[:voting_record]
                    next
                end
                g.yield parse_line(line)
            }
        }
    end

    def next
        @records.next
    end

    alias next_record next

    def next?
        @records.next?
    end

    alias next_record? next?
end

# p = ProcessData.new
# p p.next
