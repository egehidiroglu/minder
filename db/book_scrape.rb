require 'rspotify'
require 'open-uri'
require 'json'
require 'nokogiri'
require 'rest-client'

# authors = []
# new_book_releases = []

# url = "https://www.amazon.ca/s?i=stripbooks&rh=n%3A916520%2Cp_n_date%3A12035758011&qid=1661623165&ref=sr_pg_1"
# html_file = URI.open(url).read
# html_doc = Nokogiri::HTML(html_file)

# book_url = ""
# html_doc.search(".s-line-clamp-2 .a-link-normal").each do |author|
#   book_url = "https://www.amazon.ca#{author.attribute("href").value}"
#   p book_url
#   # use the url to access the page
#   html_file = URI.open(book_url).read
#   html_doc = Nokogiri::HTML(html_file)
#   # find the isbn-13 in the page
#   html_doc.search(".rpi-carousel-attribute-card .rpi-attribute-content .rpi-attribute-value").each do |element|
#     p element.text.strip
#     if element.text.strip[3] == "-"
#       new_book_releases << element.text.strip
#     end
#   end
# end


# url = book_url
# html_file = URI.open(url).read
# html_doc = Nokogiri::HTML(html_file)

# html_doc.search(".rpi-carousel-attribute-card .rpi-attribute-content .rpi-attribute-value").each do |element|
#   if element.text.strip[3] == "-"
#     new_book_releases << element.text.strip
#   end
# end

# p new_book_releases


# html_doc.search("span.a-size-base").each do |author|
#   if author.text.strip[-4..-1] == "2022" || author.text.strip[-4..-1] == "2023"
#     p author.text.strip
#   end
# end

# url = "https://www.goodreads.com/book/popular_by_date/2022"
# html_file = URI.open(url).read
# html_doc = Nokogiri::HTML(html_file)

# good_reads_links = []
# html_doc.search("h3 a").each do |author|
#    good_reads_links << author.attribute("href").value
# end

# authors = ["Malcolm Gladwell", "Stephen King", "Ryan Holiday",
#     "J.K. Rowling", "Robert Galbraith", "Jamie Oliver", "Jonathan Cahn", "Ryan Holiday",
#     "Jonathan Cahn", "Rupi Kaur", "Matthew Perry", "Randall Munroe",
#     "Kate Reid", "Gabor Mate", "Michelle Obama", "Jamie Oliver",
#     "Christine Sinclair", "Bob Dylan", "Jerry Seinfeld"]

# authors = ["Colleen Hoover"]

# authors.each do |author|
#   author.gsub!(" ", "_")
#   url = "https://en.wikipedia.org/wiki/#{author}"
#   p url
#   html_file = URI.open(url).read
#   html_doc = Nokogiri::HTML(html_file)

#   html_doc.search(".infobox-image img").each do |element|
#     p element.attributes["src"].value
#   end
# end

# artists = ["Muse", "Lou Reed", "DJ Khaled", "Ezra Furman", "Pantha Du Prince", "Embrace", "Death Scythe", "Megadeth", "Ozzy Osbourne",
#   "Beacon", "Inglorious", "Ringo Starr", "Clutch", "Codeine", "Nikki Lane", "Bjork", "Slipknot",
#   "Kolb", "Young the Giant", "The Snuts", "Bill Callahan", "Loyle Carner", "Kailee Morgue",
#   "Twenty One Pilots", "Elsiane", "Zimmer", "ODESZA", "My Chemical Romance", "Backstreet Boys",
#   "Shame", "The White Buffalo", "Knocked Loose", "Jonas", "Aitch", "Regal",
#   "Porcupine Tree", "Lynda Lemay", "Stick To Your Guns", "Zucchero", "Jungle",
#   "Ibrahim Maalouf", "The Killers", "RY X", "Matt Lang", "Spencer Brown",
#   "Trentemoller", "Novo Amor", "Cigarettes After Sex", "Julien Clerc", "Gorillaz",
#   "Demi Lovato", "The Smashing Pumpkins", "Tommy Cash", "Peach Tree Rascals", "Tchami",
#   "Skullcrusher", "Alan Walker", "The Smile", "Stromae"]


#   artists.each do |artist|
#   begin
#     artist.gsub!(" ", "_")
#     url = "https://en.wikipedia.org/wiki/#{artist}"
#     p url
#     html_file = URI.open(url).read
#     html_doc = Nokogiri::HTML(html_file)
#     photo = ""
#     html_doc.search(".infobox-image img").each do |element|
#       photo = element.attributes["src"].value
#     end
#   rescue
#     p "=================================nothing"
#   end
# end

# directors.each do |director|
#   tmdb_api_upcoming_call = "https://api.tmdb.org/3/search/person?api_key=63759eccae824fa88e79218786680970&query=#{director}"
#   begin
#     response = URI.open(tmdb_api_upcoming_call).read
#     results = JSON.parse(response)
#     actor_id = results["results"][0]["id"]

#     tmdb_api_actor_photo = "https://api.themoviedb.org/3/person/#{actor_id}/images?api_key=63759eccae824fa88e79218786680970"
#     response = URI.open(tmdb_api_actor_photo).read
#     results = JSON.parse(response)
#     path = "https://image.tmdb.org/t/p/w220_and_h330_face/#{results["profiles"][0]["file_path"]}"
#   rescue
#     p director
#   end
# end

# artists = ["Muse", "Lou Reed", "DJ Khaled", "Ezra Furman", "Pantha Du Prince", "Embrace", "Death Scythe", "Megadeth", "Ozzy Osbourne",
#   "Beacon", "Inglorious", "Ringo Starr", "Clutch", "Codeine", "Nikki Lane", "Bjork", "Slipknot",
#   "Kolb", "Young the Giant", "The Snuts", "Bill Callahan", "Loyle Carner", "Kailee Morgue",
#   "Twenty One Pilots", "Elsiane", "Zimmer", "ODESZA", "My Chemical Romance", "Backstreet Boys",
#   "Shame", "The White Buffalo", "Knocked Loose", "Jonas", "Aitch", "Regal",
#   "Porcupine Tree", "Lynda Lemay", "Stick To Your Guns", "Zucchero", "Jungle",
#   "Ibrahim Maalouf", "The Killers", "RY X", "Matt Lang", "Spencer Brown",
#   "Trentemoller", "Novo Amor", "Cigarettes After Sex", "Julien Clerc", "Gorillaz",
#   "Demi Lovato", "The Smashing Pumpkins", "Tommy Cash", "Peach Tree Rascals", "Tchami",
#   "Skullcrusher", "Alan Walker", "The Smile", "Stromae"]

# artists.each do |artist|
#   artist.gsub!(" ", "_")
#   url = "https://en.wikipedia.org/wiki/#{artist}"
#   html_file = URI.open(url).read
#   html_doc = Nokogiri::HTML(html_file)
#   image = ""
#   html_doc.search(".infobox-image img").each do |element|
#     image = element.attributes["src"].value
#   end
#   if image == ""
#     puts artist
#     puts "backup plan!!---------------"
#     # url = "https://en.wikipedia.org/wiki/#{artist}_(band)"
#     # html_file = URI.open(url).read
#     # html_doc = Nokogiri::HTML(html_file)
#     # html_doc.search(".infobox-image img").each do |element|
#     #   image = element.attributes["src"].value
#     # end
#   end
#   puts artist
#   p "artist-----> #{image}"
#   puts ""
#   # creator.poster_url = image
#   # creator.save!
#   # path = ""
# end

authors = ["Malcolm Gladwell", "Stephen King", "Ryan Holiday", "J.K. Rowling", "Jamie Oliver",
  "Jonathan Cahn", "Rupi Kaur", "Randall Munroe", "Kate Reid", "Gabor Mate", "Michelle Obama",
  "Christine Sinclair", "Imani Perry", "Chuck Klosterman", "Margaret Atwood", "Zadie Smith"]

authors.each do |author|
  search = URI.open("https://www.googleapis.com/books/v1/volumes?q=inauthor:#{author}&orderBy=newest&num=1&langRestrict=en&key=#{ENV["GOOGLE_KEY"]}").read
  response = JSON.parse(search)
  isbn = response["items"][0]["volumeInfo"]["industryIdentifiers"][0]["identifier"]
  p isbn
end

authors.each do |author|
  author.gsub!(" ", "%20")
  results = RestClient.get("https://api2.isbndb.com/author/#{author}?page=30&pageSize=10",
  headers={"Authorization" => "48314_72662961febf77ecb4b86a768b7ca6dc"})
  p "#{author} ---> #{JSON.parse(results)["books"].first["image"]}"
end
