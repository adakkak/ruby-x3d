require 'string_distance'
require 'process_data'

def KMeansClustering
    def initialize
        # file_name = "data/LUCAS.TXT"
        @file_name = "data/LUCAS_SAMPLE.TXT"
        @records = ProcessData.new :file_name => @file_name
    end
end
