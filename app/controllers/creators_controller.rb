class CreatorsController < ApplicationController
  def my_creators
    followed_creators = current_user.followed_creators
    if params[:query].present?
      case params[:query]
      when "Music"
        @creators = []
        followed_creators.each do |followed|
          @creators.push(followed) if followed.creator.content_type == "Music"
        end
      when "Movie"
        @creators = []
        followed_creators.each do |followed|
          @creators.push(followed) if followed.creator.content_type == "Movie"
        end
      when "Book"
        @creators = []
        followed_creators.each do |followed|
          @creators.push(followed) if followed.creator.content_type == "Book"
        end
      end
    else
      @creators = current_user.followed_creators
    end
  end

  def new
    @creator = Creator.new
  end

  def create
    @creator = Creator.new(creator_params)
    @creator.save
    followed_creator = FollowedCreator.new
    followed_creator.creator = @creator
    followed_creator.user = current_user
    if followed_creator.save
      redirect_to my_creators_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
  end

  private

  def creator_params
    params.require(:creator).permit(:name, :content_type)
  end
end
