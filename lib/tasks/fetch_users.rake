desc "Fetch user info from dou.ua"
task :fetch_users => :environment do

require 'rubygems'
require 'nokogiri'
require 'open-uri'

DOU_FORUM_URL = "http://dou.ua/forums/"

forums_page = Nokogiri::HTML(open(DOU_FORUM_URL))

topic_urls = forums_page.css("a[href^='http://dou.ua/forums/topic/']")

topic_urls.each do |topic|

  topic_link = "#{topic['href']}"

  page = Nokogiri::HTML(open(topic_link))

  users_info_links = page.css("a.avatar")

  users_info_links.each do |info|
    user_url = "#{info["href"]}"

    user_page = Nokogiri::HTML(open(user_url))
    user_name = user_page.at_css("title").content.gsub!(' | DOU', '')
    user_description = user_page.at_css("meta[name='description']")
    user_company = user_page.at_css("a.company span")

    User.find_or_create_by(name: user_name) do |user|

      user.description = user_description["content"]
      if user_company
        user.company = user_page.at_css("a.company span").content
      end
    end
  end
end
end

