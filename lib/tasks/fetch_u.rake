desc "Fetch user  from dou.ua"
task :fetch_u => :environment do

require 'rubygems'
require 'nokogiri'
require 'open-uri'


  topic = Nokogiri::HTML(open('http://dou.ua/forums/topic/11985/'))

  users_info_links = topic.css("a.avatar")

  users_info_links.each do |info|
    user_url = "#{info["href"]}"

    user_page = Nokogiri::HTML(open(user_url))
    user_name = user_page.at_css("title").content.gsub!(' | DOU', '')
    user_description = user_page.at_css("meta[name='description']")["content"]
    company = user_page.at_css("div.descr span")
    user_company = company.content if company

    update_user = User.find_or_create_by(name: user_name) do |user|

      user.description = user_description
      user.company = user_company if user_company
      user.url = user_url

    end

    update_user.update(description: user_description) if update_user.description != user_description
    update_user.update(company: user_company) if update_user.company != user_company
  end
end




