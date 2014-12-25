desc "Fetch user info from dou.ua"
task :fetch_users => :environment do
  puts "Updating users..."
  User.fetch_dou_users
  puts "Done ..."
end

