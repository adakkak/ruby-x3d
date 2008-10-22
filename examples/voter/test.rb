require 'helper'

s = StringDistance.new("216 UNIVERSITY BLVD", "321 UNIVERSITY BLVD")
puts s.distance

s = StringDistance.new("216 YALE BLVD", "321 UNIVERSITY BLVD")
puts s.distance
