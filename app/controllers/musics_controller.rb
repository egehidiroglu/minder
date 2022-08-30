class MusicsController < ApplicationController
  def index
    @albums = Album.all
    @concerts = Concert.all
  end

  def show
    begin
      @album_music = Album.find(params[:id])
    rescue => exception
      @concert_music = Concert.find(params[:id])
    end
  end

  def favorite_music
    begin
      album_music = Album.find(params[:id])
    rescue => e
      concert_music = Concert.find(params[:id])
    end
    if concert_music.nil?
      current_user.favorite(album_music)
    else
      current_user.favorite(concert_music)
    end
    redirect_to musics_path
  end
end
