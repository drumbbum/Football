class ProcessMatchup
  @@first_word = ['Green','Kansas','New','San','St.','Tampa']
  @@days = ['Thu,', 'Sun,', 'Mon,', 'Tue,', 'Wed,', 'Fri', 'Sat,']
  @@months = {'Sep' => 9, 'Oct' => 10, 'Nov' => 11, 'Dec' => 12, 'Jan' => 1, 'Feb' => 2}
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
    month = 0
    day = 0
    year = 2011
    File.open(path, 'r') do |f|
      while line = f.gets
        matchup = Array.new
        arr = line.split(' ')
        if @@days.include?(arr[0])
          month = @@months[arr[1]]
          day = arr[2].to_i
          if month.eql?(1)
            year = 2012
          end
        else
          # GET TEAMS
          matchup << self.getTeam!(arr)
          if !arr.shift.eql?("at")
            puts "Error in matchup "
            puts arr
          end
          matchup << self.getTeam!(arr)        
          ## GET TIME
          time = arr.shift.split(':')
          if time[0].to_i > 12
            time[0] = time[0].to_i + 12
          end
          matchup << year
          matchup << month
          matchup << day
          matchup << time[0].to_i
          matchup << time[1].to_i
          matchups << matchup
        end
      end
    end
    matchups
  end
end
