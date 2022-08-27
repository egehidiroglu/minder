require "open-uri"
require "nokogiri"

authors = []
url = "https://www.theguardian.com/books/list/authorsaz"
html_file = URI.open(url).read
html_doc = Nokogiri::HTML(html_file)

html_doc.search("#index-wrapper li").each do |author|
  author.text.strip
end
