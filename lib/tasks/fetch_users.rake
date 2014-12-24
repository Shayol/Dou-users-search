desc "Fetch user info from dou.ua"
task :fetch_users => :environment do

  puts "start fetching"
  User.fetch_dou_users
  puts "ended fetching"
end

