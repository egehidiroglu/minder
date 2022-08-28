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

authors = ["Malcolm Gladwell", "Colleen Hoover", "Stephen King",
  "J.K. Rowling", "Robert Galbraith", "Jamie Oliver", "Yung Pueblo", "Jonathan Cahn", "Ryan Holiday", "Bill Bryson"]

authors.each do |author|
  buffer = URI.open("https://www.googleapis.com/books/v1/volumes?q=inauthor:#{author}&orderBy=newest&num=1&langRestrict=en&key=AIzaSyBVAhKIqj9SaJNdNyN1oPSnLb5AUnb6KXE").read
  response = JSON.parse(buffer)
  p response["items"][0]["volumeInfo"]["title"]
  p response["items"][0]["volumeInfo"]["publishedDate"]
  p response["items"][0]["volumeInfo"]["authors"][0]
  p response["items"][0]["volumeInfo"]["description"]
  p response["items"][0]["volumeInfo"]["imageLinks"]["thumbnail"]
end
