class MusicsController < ApplicationController
  def index
    @albums = Album.all
    @concerts = Concert.all
  end

  def show
  end
end
