require 'rubygems'
require 'mechanize'
require "open-uri"
require "nokogiri"

agent = Mechanize.new

page = agent.get('http://www.chasseurdemigrateurs.com/meteo/view/2015/11/03')

doc = Nokogiri::HTML(open('http://www.chasseurdemigrateurs.com/meteo/view/#{year}/#{month}/#{day}'))
doc.search('.meteoResume').each do |element|
  puts element.text
end
