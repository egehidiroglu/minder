require 'rspotify'
require 'open-uri'
require 'json'
require 'nokogiri'

tmdb_api_key = "63759eccae824fa88e79218786680970"

# RSpotify.authenticate("9c4f0907d3714790a061805fc1301430", "318e8535fa704c37a62573152d9c4152")
# albums = RSpotify::Album.new_releases(limit: 50, country: "US")

# albums.each do |album|
#   p album.release_date
#   p album.name
#   p album.artists[0].name
#   puts " "
# end

base_url = 'https://www.metacritic.com/browse/albums/release-date/coming-soon/date'
user_agent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/97.0.4692.99 Safari/537.36"

# html = URI.parse(base_url).open("User-Agent" => user_agent)
# doc = Nokogiri::HTML(html)
doc = Nokogiri::HTML(File.open('date.html'))

p doc

today = Date.today
today = today.strftime("%F")
six_months = Date.today + 180
six_months = six_months.strftime("%F")
p today
p six_months

for i in 1..10
  page = i
  tmdb_api_call = "https://api.themoviedb.org/3/discover/movie?api_key=63759eccae824fa88e79218786680970&language=en-US&primary_release_date.gte=#{today}&primary_release_date.lte=#{six_months}&page=#{page}"
  response = URI.open(tmdb_api_call).read
  results = JSON.parse(response)
  movies = results["results"]
  movies.each do |movie|
    p movie
    puts " "
  end
end
