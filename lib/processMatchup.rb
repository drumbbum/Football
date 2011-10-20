class ProcessMatchup
  @@first_word = ['Green','Kansas','New','San','St.','Tampa']
  def initialize
    @directory  = "lib/matchups/"
  end

  def getWeekFilePath(weekNumber)
    path = @directory + 'week' + weekNumber.to_s + '.txt'
  end
  
  def getTeam!(arr)
    if @@first_word.include?(arr.first)
      city = arr.shift + ' ' + arr.shift
      if city.include?("York")
        city << ' ' + arr.shift
      end
    else
      city = arr.shift
    end
    return city
  end
  
  def createMatchupArray(path)
    matchups = Array.new
    File.open(path, 'r') do |f|
      while line = f.gets
        arr = line.split(' ')
        matchup = Array.new
        matchup << self.getTeam!(arr)
        if !arr.shift.eql?("at")
          puts "Error in matchup "
          puts arr
        end
        matchup << self.getTeam!(arr)
        matchups << matchup
      end
    end
    matchups
  end
end
