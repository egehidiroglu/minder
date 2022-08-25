class CreatorsController < ApplicationController
  def my_creators
    followed_creators = current_user.followed_creators
    if params[:query].present?
      case params[:query]
      when "Music"
        @creators = []
        followed_creators.each do |followed|
          @creators.push(followed) if followed.creator.content_type == "music"
        end
      when "Movie"
        @creators = []
        followed_creators.each do |followed|
          @creators.push(followed) if followed.creator.content_type == "movie"
        end
      when "Book"
        @creators = []
        followed_creators.each do |followed|
          @creators.push(followed) if followed.creator.content_type == "book"
        end
      end
    else
      @creators = current_user.followed_creators
    end
  end

  def new

  end

  def create
  end

  def destroy
  end
end
