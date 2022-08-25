require 'rspotify'
require 'open-uri'
require 'json'
require 'nokogiri'
require 'rest-client'

# ================================= Books Start ==========================================

year = Time.now.year
my_authors = ["Bill Bryson", "Malcolm Gladwell", "stephen king", "Jamie Oliver", "J.K. Rowling", "John Green"]

my_authors.each do |author|
  author.gsub!(" ", "%20")
  results = RestClient.get("https://api2.isbndb.com/author/#{author}?page=30&pageSize=10", headers={
  "Authorization" => "48319_4e34c087665fdc89f0b3213205531ec7"
  })
  JSON.parse(results)["books"].each do |book|
    #  -------------Converting all formats to date format------------------------
    # begin
      # publishing_date = Date.parse(book["date_published"])
      # This just works for
    # rescue
      # Use Regex to get the year from: book["date_published"] and store in publishing_date
      # Date.new and just set it to jan. 1 of that year
    # end

    if book["date_published"].to_i >= year - 10
      Book.create(
        name: book["title"],
        release_date: book["date_published"],
        description: book["synopsys"],
        poster_url: book["image"],
        creator_id: 1
      )
      p "Added -------->   .#{book['title']} Year: #{book['date_published']}"
    end
  end

# my_authors.each do |author|
#   # author.gsub!(" ", "%20")
#   url = "https://api2.isbndb.com/author/#{author}?page=1&pageSize=20"
#   response = URI.open(url).read
#   p response
#   results = JSON.parse(response)
#   p results
#   books = results["books"]
#   p books
# end

# ================================= Books End ==========================================

# ================================= Creators Start ==========================================

p "Destroying users..."
User.destroy_all
p "Destroying creators..."
Creator.destroy_all
p "Destroying followed creators..."
FollowedCreator.destroy_all

p "Creating a user..."
user = User.new
user.email = "egehdrgl@gmail.com"
user.password = "123456"
user.save

artists = ["Muse", "Lou Reed", "DJ Khaled", "Ezra Furman", "Pantha Du Prince", "Embrace",
           "Fargo Q Money", "Death Scythe", "Kim Areum", "Megadeth", "Gaspar Claus", "Ozzy Osbourne",
           "Beacon", "Inglorious", "Ringo Starr", "Clutch", "Codeine", "Nikki Lane", "Bjork", "Slipknot",
           "Kolb", "Young the Giant", "The Snuts", "Bill Callahan", "Loyle Carner", "Kailee Morgue",
           "Twenty One Pilots", "Elsiane", "Zimmer", "ODESZA", "My Chemical Romance", "Backstreet Boys",
           "Shame", "The White Buffalo", "Knocked Loose", "Jonas", "Aitch", "Regal", "Ryan Castro",
           "Porcupine Tree", "Lewis Ofman", "Lynda Lemay", "Stick To Your Guns", "Zucchero", "Jungle",
           "Ibrahim Maalouf", "The Killers", "RY X", "Ringo Starr", "Matt Lang", "Spencer Brown",
           "Trentemoller", "Novo Amor", "Cigarettes After Sex", "Julien Clerc", "Gorillaz", "Fouki",
           "Demi Lovato", "The Smashing Pumpkins", "Tommy Cash", "Peach Tree Rascals", "Tchami",
           "Skullcrusher", "Alan Walker", "The Smile", "Stromae"]

directors = ["Jon Watts", "Gina Prince-Bythewood", "Zach Cregger", "George Miller", "Castille Landon",
             "Paul Fisher", "David Gordon Green", "Parker Finn", "Ol Parker", "Adamma Ebo", "Nicholas Stoller", "Carlota Pereda",
             "Guillaume Lambert", "Nick Hamm", "James Cameron", "Mark Mylod", "Ryan Coogler", "Robert Zappia", "Jaume Collet-Serra"]

p "Creating music creators..."
artists.each do |artist|
  creator = Creator.new
  creator.name = artist
  creator.content_type = "music"
  creator.save
end

p "Creating movie creators..."
directors.each do |director|
  creator = Creator.new
  creator.name = director
  creator.content_type = "movie"
  creator.save
end

p "Assigning creators to user's followed creators..."
Creator.all.each do |creator|
  followed_creator = FollowedCreator.new
  followed_creator.user = User.all.first
  followed_creator.creator = creator
  followed_creator.save
end

p "Finding upcoming albums for creators..."
for page in 1..11
  i = 1
  doc = Nokogiri::HTML(URI.open("https://www.albumoftheyear.org/upcoming/#{page}/"))
  doc.search('.albumBlock').each do |link|
    img = link.search('img').attr('data-srcset').value unless link.search('img').attr('data-srcset').nil?
    img = img.split[0] unless img.nil?
    date = link.search('.date').text.strip
    date = Date.parse(date).strftime("%F") unless date.length.zero?
    artist_title = link.search('.artistTitle').text.strip
    album_title = link.search('.albumTitle').text.strip

    unless date.nil? && artist_title.nil?
      if Creator.where(name: artist_title)
        album = Album.new
        album.poster_url = img.nil? ? "" : img
        album.release_date = date
        album.name = album_title
        album.creator = Creator.where(name: artist_title).first
        album.save
      end
    end
    break if i == 60

    i += 1
  end
end

p "Finding concerts for creators..."
Creator.all.each do |artist|
  buffer = URI.open("https://app.ticketmaster.com/discovery/v2/events.json?size=10&apikey=453PeGFeKAA4XhceoIbBOUhfFIs2SOln&city=Montreal&keyword=#{artist.name}").read
  response = JSON.parse(buffer)["_embedded"]
  unless response.nil?
    event = response["events"].first
    event_name = event["name"]
    event_image = event["images"].first["url"]
    event_date = event["dates"]["start"]["localDate"]
    event_url = event["url"]
    event_venue = event["_embedded"]["venues"].first["name"]
    event_address = event["_embedded"]["venues"].first["address"]["line1"]
  end
  unless event.nil?
    concert = Concert.new
    concert.name = event_name
    concert.date = event_date
    concert.venue = event_venue
    concert.address = event_address
    concert.poster_url = event_image
    concert.event_url = event_url
    concert.creator = artist
    concert.save
  end
  sleep(0.5)
end

today = Date.today
today = today.strftime("%F")
six_months = Date.today + 180
six_months = six_months.strftime("%F")

TMDB_API_KEY = "63759eccae824fa88e79218786680970"

p "Finding upcoming movies from creators..."
for i in 1..10
  tmdb_api_upcoming_call = "https://api.themoviedb.org/3/discover/movie?api_key=#{TMDB_API_KEY}&language=en-US&primary_release_date.gte=#{today}&primary_release_date.lte=#{six_months}&page=#{i}"
  response = URI.open(tmdb_api_upcoming_call).read
  results = JSON.parse(response)
  movies = results["results"]
  movies.each do |movie|
    movie_id = movie["id"]
    tmdb_api_credits_call = "https://api.themoviedb.org/3/movie/#{movie_id}/credits?api_key=#{TMDB_API_KEY}&language=en-US"
    credits_response = URI.open(tmdb_api_credits_call).read
    credits_results = JSON.parse(credits_response)
    movie_cast = credits_results["crew"]
    movie_cast.each do |crew|
      director = crew["name"] if crew["job"] == "Director"
      if Creator.where(name: director)
        mov = Movie.new
        mov.name = movie["original_title"]
        mov.release_date = movie["release_date"]
        mov.description = movie["overview"]
        mov.poster_url = "https://image.tmdb.org/t/p/w500#{movie['poster_path']}"
        mov.creator = Creator.where(name: director).first
        mov.save
      end
    end
  end
end
# ================================= Creators End =========================================
