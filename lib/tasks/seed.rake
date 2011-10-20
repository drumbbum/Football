namespace :seed do
  
  desc "Add Team Names to Team"
  task :team => :environment do
    first_word = ['Green','Kansas','New','San','St.','Tampa','NY']
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
          Team.create(:city => city, :name => name, :full_name => full_name)
        end
      end
    end
  end
  
  desc "Add Matchups to Database"
  task :matchup => :environment do
    load "lib/processMatchup.rb"
    pm = ProcessMatchup.new
    (1..17).each do |i|
      path = pm.getWeekFilePath(i)
      matchups = pm.createMatchupArray(path)
      matchups.each do |matchup|
        away = Team.find_by_city(matchup[0]) || Team.find_by_full_name(matchup[0])
        home = Team.find_by_city(matchup[1]) || Team.find_by_full_name(matchup[1])
        Matchup.create(:away => away.id, :home => home.id, :week => i)
      end
    end
  end
  
end