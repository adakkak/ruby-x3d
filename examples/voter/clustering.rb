require 'string_distance'
require 'process_data'

def KMeansClustering
    def initialize
        # file_name = "LUCAS.TXT"
        @file_name = "LUCAS_SAMPLE.TXT"
        @records = ProcessData.new :file_name => @file_name
    end
end
