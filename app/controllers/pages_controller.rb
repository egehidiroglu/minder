class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @artists = RSpotify::Artist.search('Arctic Monkeys')
  end
end
