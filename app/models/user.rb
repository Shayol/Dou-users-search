class User < ActiveRecord::Base
  validates :name,  presence: true
  validates :description,  presence: true
  validates :url,  presence: true

  DOU_FORUM_URL = "http://dou.ua/forums/"

  def self.fetch_dou_users

    require 'rubygems'
    require 'nokogiri'
    require 'open-uri'

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
        user_description = user_page.at_css("meta[name='description']")["content"]
        company = user_page.at_css("div.descr span")
        user_company = company.content if company

        update_user = User.find_or_create_by(name: user_name) do |user|
          user.update(description: user_description)
          user.update(company: user_company) if user_company
          user.update(url: user_url)
        end

        update_user.update(description: user_description) if update_user.description != user_description
        update_user.update(company: user_company) if update_user.company != user_company
      end
    end
  end
end
