class UsersController < ApplicationController
  def spotify
    spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    artists = spotify_user.following(type: "artist", limit: 20)
    artists.each do |artist|
      name = artist.name
      photo = artist.images.second["url"]
      followed = FollowedCreator.new
      if Creator.where(name: name).empty?
        creator = Creator.new
        creator.name = name
        creator.poster_url = photo
        creator.content_type = "Music"
        creator.save
        followed.creator = creator
        followed.user = current_user
      else
        creator = Creator.where(name: name).first
        followed.creator = creator
        followed.user = current_user
      end
      followed.save
    end
    redirect_to artist_setup_path
  end

  def my_favorites
    user_favorites = current_user.all_favorited
    filter_params = ["Music", "Movie", "Book"]
    if params[:query].present?
      if filter_params.include?(params[:query])
        case params[:query]
        when "Music"
          @favorites = []
          user_favorites.each do |followed|
            @favorites.push(followed) if followed.instance_of?(Album) || followed.instance_of?(Concert)
          end
        when "Movie"
          @favorites = []
          user_favorites.each do |followed|
            @favorites.push(followed) if followed.instance_of?(Movie.new.class)
          end
        when "Book"
          @favorites = []
          user_favorites.each do |followed|
            @favorites.push(followed) if followed.instance_of?(Book.new.class)
          end
        end
      else
        sql_query = <<~SQL
          books.name ILIKE :query
          OR books.description ILIKE :query
          OR creators.name ILIKE :query
        SQL
        books = Book.joins(:creator).where(sql_query, query: "%#{params[:query]}%")
        sql_query = <<~SQL
          albums.name ILIKE :query
          OR creators.name ILIKE :query
        SQL
        albums = Album.joins(:creator).where(sql_query, query: "%#{params[:query]}%")
        sql_query = <<~SQL
          concerts.name ILIKE :query
          OR concerts.venue ILIKE :query
          OR creators.name ILIKE :query
        SQL
        concerts = Concert.joins(:creator).where(sql_query, query: "%#{params[:query]}%")
        sql_query = <<~SQL
          movies.name ILIKE :query
          OR movies.description ILIKE :query
          OR creators.name ILIKE :query
        SQL
        music = Movie.joins(:creator).where(sql_query, query: "%#{params[:query]}%")
        results = [books, albums, concerts, music]
        results.each do |result|
          @favorites = result unless result.empty?
        end
      end
    else
      @favorites = current_user.all_favorited
    end
  end

  def unfavorite
    favorited = current_user.all_favorited
    to_unfav = 0
    favorited.each do |fav|
      to_unfav = fav if fav.id == params[:id].to_i
    end
    current_user.unfavorite(to_unfav)
  end

  def custom_unfav
    favorited = current_user.all_favorited
    to_unfav = 0
    favorited.each do |fav|
      to_unfav = fav if fav.id == params[:id].to_i
    end
    current_user.unfavorite(to_unfav)
  end
end
