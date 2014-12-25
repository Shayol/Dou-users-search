desc "Fetch user info from dou.ua"
task :fetch_users => :environment do
  User.fetch_dou_users
end

