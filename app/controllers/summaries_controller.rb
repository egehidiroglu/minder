class SummariesController < ApplicationController
  def index
    @movie = Movie.first
    @book = Book.first
    @album = Album.first

    if params[:spotify_import].present?
      flash.now[:notice] = "You have imported 257 artists from Spotify"
    end
  end
end
