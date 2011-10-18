namespace :seed do
  
  desc "Add Team Names to Team"
  task :team => :environment do
    File.open('lib/teams.txt', 'r') do |f|
      while line = f.gets
        unless Team.find_by_name(line)
          Team.create(:name => line)
        end
      end
    end
  end
  
end