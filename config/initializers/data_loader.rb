puts "data_loader.rd sleeping"
sleep(10)
puts "data_loader.rb Starting"

load "#{RAILS_ROOT}/Rakefile"
Rake::Task['bootstrap:all'].invoke
