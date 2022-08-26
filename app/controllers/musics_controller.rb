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
end
