class MoviesController < ApplicationController
  def index
    @movies = Movie.all
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def favorite_movie
    movie = Movie.find(params[:id])
    user = current_user
    user.favorite(movie)
    redirect_to movies_path
  end
end
