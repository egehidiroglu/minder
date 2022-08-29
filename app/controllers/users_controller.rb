class UsersController < ApplicationController
  def spotify
    @spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
  end

  def my_favorites
    user = current_user
    @favorites = user.all_favorited

    user_favorites = current_user.all_favorited
    if params[:query].present?
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
      @favorites = current_user.all_favorited
    end
  end

  
end
