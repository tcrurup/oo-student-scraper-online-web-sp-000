require 'open-uri'
require 'pry'

class Scraper

  #name: student.css(".student-name").text
  #location: student.css("student-location").text
  #profile_url: student.css("a").attribute("href").value
  
  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open index_url)
    all_profiles = []
    
    index_page.css(".student-card").each do |student|
      student_hash = {}
      student_hash[:name] = student.css(".student-name").text
      student_hash[:location] = student.css(".student-location").text
      student_hash[:profile_url] = student.css("a").attribute("href").value
      all_profiles << student_hash
    end
    
    all_profiles
  end

  #twitter url social_data.attribute("href").value
  #linkedin url 
  #github url 
  #blog url
  #profile quote
  #bio
  
  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open profile_url)
    profile_hash = {}
    profile_name = profile_page.css("h1.profile-name").text

    profile_page.css("div.social-icon-container a").each do |social_data|
      
      website_url = social_data.attribute("href").value
      website_name = website_url.match(/\/\/w{0,3}\.?(\S+).com/)
      
      unless  website_name.nil?
      
        #Check for a twitter, github, or linkedin account.  Create symbols for each website
        #and assign them their corresponding url
<<<<<<< HEAD
        if ["twitter", "github", "linkedin"].include?(website_name[1])
         profile_hash[website_name[1].to_sym] = website_url
=======
        if ["twitter", "github", "linkedin"].include?(website_name)
         profile_hash[website_name.to_sym] = website_url
>>>>>>> 654a7a5ee6cd85de6c2b693d346174c948e03505
        end
      
        #Check if the url contains the profiles name.  If so set that url to the blog symbol
        if profile_name.split(" ").all? { |x| website_name[1].include?(x.downcase) }
         profile_hash[:blog] = website_url
        end
      end
    end
    
    #Finally grab the profile quote and the bio
    profile_hash[:profile_quote] = profile_page.css("div.profile-quote").text
    profile_hash[:bio] = profile_page.css("div.bio-content p").text
    profile_hash
  end
  
end

