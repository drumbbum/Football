namespace :bootstrap do
  
  desc "Run all necessary tasks"
  task :all => [:matchup] do
  end
  
  desc "Add Team Names to Team"
  task :team => :environment do
    unless Team.all.size.eql?(32)
      first_word = ['Green','Kansas','New','San','St.','Tampa']
      File.open('lib/teams.txt', 'r') do |f|
        while line = f.gets
          arr = line.split(' ')
          if first_word.include?(arr.first)
            city = arr.shift + ' ' + arr.shift
            name = arr.shift
          else
            city = arr.shift
            name = arr.shift
          end
          unless Team.find_by_name(name)
            puts city
            puts name
            full_name = city + ' ' + name
            unless Team.find_by_name(name)
              Team.create(:city => city, :name => name, :full_name => full_name)
            end
          end
        end
      end
    end
  end
  
  desc "Add Matchups to Database"
  task :matchup => :team do
    load "lib/processMatchup.rb"
    pm = ProcessMatchup.new
    (1..17).each do |i|
      path = pm.getWeekFilePath(i)
      matchups = pm.createMatchupArray(path)
      matchups.each do |matchup|
        away = Team.find_by_city(matchup[0]) || Team.find_by_full_name(matchup[0])
        home = Team.find_by_city(matchup[1]) || Team.find_by_full_name(matchup[1])
        year = matchup[2]
        month = matchup[3]
        day = matchup[4]
        hour = matchup[5]
        minute = matchup[6]
        datetime = DateTime.new(year, month, day, hour, minute)
        
        Matchup.create(:away => away.id, :home => home.id, :week => i, :time => datetime)
      end
    end
  end
  
  # desc "Seed a league"
  # task :league => :environment do
  #   League.create(:name => "Strict League", :admin => 1, :repick => false, :show_paid => false, :show_history => false)
  #   League.create(:name => "Loose League", :admin => 1, :repick => true, :show_paid => true, :show_history => true)
  # end
end