class LevenshteinDistance
    # see http://en.wikipedia.org/wiki/Levenshtein_distance
    attr_reader :distance

    def initialize(s, t)
        @s = s.downcase
        @t = t.downcase
        @distance = get_distance
    end

    private
    def zeros(m,n)
        d = []
        m.times{
            d << []
            n.times{
                d[-1] << 0
            }
        }
        return d
    end

    private
    def get_distance
        m, n  = @s.length, @t.length

        # create a zeros matrix of dimension (m+1)x(n+1)
        d = zeros(m+1, n+1)

        (0..m).each { |i|
            d[i][0] = i
        }

        (0..n).each { |j|
            d[0][j] = j
        }

        (1..m).each do |i|
            (1..n).each do |j|
                cost =  @s[i-1] == @t[j-1] ? 0 : 1

#                 p [i,j,d[i][j], d[i-1][j]+1, d[i][j-1]+1,d[i-1][j-1]+cost,cost, @s[i-1],@t[j-1]]
                d[i][j] = [d[i-1][j]   + 1,         # deletion
                           d[i][j-1]   + 1,         # insertion
                           d[i-1][j-1] + cost       # substitution
                          ].min  # take the minimum
            end
        end
        
#         p d
        d[m][n]
    end
end

class StringDistance < LevenshteinDistance
end

def test
    x = "sitting"
    y = "kitten"
    d = LevenshteinDistance.new(x,y)
#     puts d.distance
    raise "Imlementation Error" if d.distance != 3


    x = "YHCQPGK"
    y = "LAHYQQKPGKA"
    d = LevenshteinDistance.new(x,y)
#     puts d.distance
    raise "Imlementation Error" if d.distance != 6

    x = "this"
    y = "that"
    d = LevenshteinDistance.new(x,y)
#     puts d.distance
    raise "Imlementation Error" if d.distance != 2

    x = "snow"
    y = "blow"
    d = LevenshteinDistance.new(x,y)
    raise "Imlementation Error" if d.distance != 2

    x = "Saturday"
    y = "Sunday"
    d = LevenshteinDistance.new(x,y)
    raise "Imlementation Error" if d.distance != 3
end
