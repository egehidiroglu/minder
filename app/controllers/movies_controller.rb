class MoviesController < ApplicationController
  def index
    if params[:query].present?
      sql_query = <<~SQL
        movies.name ILIKE :query
        OR movies.description ILIKE :query
        OR creators.name ILIKE :query
      SQL
      @movies = Movie.joins(:creator).where(sql_query, query: "%#{params[:query]}%")
    else
      @movies = Movie.all
    end
    @pictures = @movies.sample(3)
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def favorite_movie
    movie = Movie.find(params[:id])
    user = current_user
    user.favorite(movie)
  end
end
