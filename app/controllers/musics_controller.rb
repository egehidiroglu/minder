class MusicsController < ApplicationController
  def index
    if params[:query].present?
      sql_query = <<~SQL
        albums.name ILIKE :query
        OR creators.name ILIKE :query
      SQL
      @albums = Album.joins(:creator).where(sql_query, query: "%#{params[:query]}%")
      sql_query = <<~SQL
        concerts.name ILIKE :query
        OR concerts.venue ILIKE :query
        OR creators.name ILIKE :query
      SQL
      @concerts = Concert.joins(:creator).where(sql_query, query: "%#{params[:query]}%")
    else
      @albums = Album.all
      @concerts = Concert.all
    end
    @pictures = Album.all.sample(2) + Concert.all.sample(1)
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
  end
end
