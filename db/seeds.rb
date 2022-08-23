<<<<<<< HEAD
require 'rspotify'
require 'open-uri'
require 'json'

tmdb_api_key = "63759eccae824fa88e79218786680970"

# RSpotify.authenticate("9c4f0907d3714790a061805fc1301430", "318e8535fa704c37a62573152d9c4152")
# albums = RSpotify::Album.new_releases(limit: 50, country: "US")

# albums.each do |album|
#   p album.release_date
#   p album.name
#   p album.artists[0].name
#   puts " "
# end

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
