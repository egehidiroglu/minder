class UsersController < ApplicationController
  def spotify
    @spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
  end

  def my_favorites
    user = current_user
    @favorites = user.all_favorited
  end
end
