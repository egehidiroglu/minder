class MusicsController < ApplicationController
  def index
    @albums = Album.all
    @concerts = Concert.all
  end

  def show
    @album_music = Album.find(params[:id])
    @concert_music = Concert.find(params[:id])
  end
end
