require 'open-uri'
require 'nokogiri'
require 'pry-byebug'

namespace :domains do
  desc "Update domains"
  task :update_all => :environment do
    Domain.all.each do |domain|
    # domain = Domain.first
      p "--------------------------------------------------"
      p domain.name
      url_snow = "https://www.skiinfo.fr/#{domain.mountain_chain}/#{domain.name_url}/bulletin-neige.html"
      html_file = open(url_snow).read
      html_doc = Nokogiri::HTML(html_file)

      html_doc.search('.elevation.lower .bluePill').each do |element|
        puts "Snow depth at the Resort (cm) : "
        p domain.snow_depth_low = element.text.strip.split('cm')[0].to_i

        html_doc.search('.elevation.upper .bluePill').each do |element|
          puts "Snow depth at the Domain's top (cm) : "
          p domain.snow_depth_high = element.text.strip.split('cm')[0].to_i
          p "- - - - - - - - - - - - - - - - - - - - - - -"

          url_weather = "https://www.skiinfo.fr/#{domain.mountain_chain}/#{domain.name_url}/meteo-a-10-jours.html"
          html_file_weather = open(url_weather).read
          html_doc_weather = Nokogiri::HTML(html_file_weather)
          p Date.new(Time.now.year, Time.now.month, Time.now.day)
          html_doc_weather.search('.weather')[0...1].each do |element|
            condition = element.children[1].attributes['class'].value.split(' ').drop(1)[0]
            p domain.is_sunny = condition
            p domain.is_sunny = condition == "sun"  ? true : false
            domain.save
          end
          p "- - - - - - - - - - - - - - - - - - - - - - -"
          html_doc_weather.search('.weather')[1..7].each do |element|
            condition = element.children[1].attributes['class'].value.split(' ').drop(1)[0]
            p domain.forecast_data = condition
            p domain.forecast_data = condition == "sun"  ? true : false
            domain.save
          end
        end
      end
    end
  end
end