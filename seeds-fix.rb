require 'rspotify'
require 'open-uri'
require 'json'
require 'nokogiri'
require 'rest-client'

authors = ["Malcolm Gladwell", "Stephen King", "Ryan Holiday", "J.K. Rowling", "Robert Galbraith", "Jamie Oliver",
  "Jonathan Cahn", "Rupi Kaur", "Matthew Perry", "Randall Munroe", "Kate Reid", "Gabor Mate", "Michelle Obama",
  "Christine Sinclair", "Bob Dylan", "Jerry Seinfeld"]

p "Creating books"
authors.each do |author|
  search = URI.open("https://www.googleapis.com/books/v1/volumes?q=inauthor:#{author}&orderBy=newest&num=1&langRestrict=en&key=#{ENV["GOOGLE_KEY"]}").read
  response = JSON.parse(search)
  p response["items"][0]["volumeInfo"]["imageLinks"]["thumbnail"]
  Book.create!(
    name: response["items"][0]["volumeInfo"]["title"],
    release_date: response["items"][0]["volumeInfo"]["publishedDate"],
    description: response["items"][0]["volumeInfo"]["description"],
    poster_url:   response["items"][0]["volumeInfo"]["imageLinks"]["thumbnail"],
    creator_id: Creator.where(name: author).first.id
  )
end
