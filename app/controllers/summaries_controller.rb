class SummariesController < ApplicationController
  def index
    @movie = Movie.first
    @book = Book.first
    @album = Album.first
  end
end
