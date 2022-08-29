class CreatorsController < ApplicationController
  def my_creators
    followed_creators = current_user.creators
    if params[:query].present?
      case params[:query]
      when "Music"
        @creators = []
        followed_creators.each do |followed|
          @creators.push(followed) if followed.content_type == "Music"
        end
      when "Movie"
        @creators = []
        followed_creators.each do |followed|
          @creators.push(followed) if followed.content_type == "Movie"
        end
      when "Book"
        @creators = []
        followed_creators.each do |followed|
          @creators.push(followed) if followed.content_type == "Book"
        end
      end
    else
      @creators = current_user.creators
    end
  end

  def new
    @followed_creator = FollowedCreator.new
    creators = Creator.all
    @unfollowed_creators = []
    creators.each do |creator|
      @unfollowed_creators.push creator if creator.users.where(id: current_user).empty?
    end
  end

  def create
    creator = Creator.where(name: creator_params["creator"])
    search = FollowedCreator.where(creator_id: creator.first.id, user_id: current_user.id)
    @followed_creator = FollowedCreator.new
    if search.empty?
      @followed_creator.creator = creator.first
      @followed_creator.user = current_user
      @followed_creator.save
      redirect_to my_creators_path, status: :see_other
    else
      @creators = Creator.all
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @creator = Creator.find(params[:id])
    @creator.destroy
    redirect_to my_creators_path, status: :see_other
  end

  # ----------------First time user signs in - choose artists--------------------WORKING
  def artist_setup
    artists = Creator.where(content_type: "Music")
    @unfollowed_artists = []
    artists.each do |creator|
      @unfollowed_artists.push creator if creator.users.where(id: current_user).empty?
    end
  end

  # ----------------First time user signs in - choose authors-------------------- WORKING

  def author_setup
    authors = Creator.where(content_type: "Book")
    @unfollowed_authors = []
    authors.each do |creator|
      @unfollowed_authors.push creator if creator.users.where(id: current_user).empty?
    end
  end

  # ----------------First time user signs in - choose directors-------------------- WORKING
  def director_setup
    directors = Creator.where(content_type: "Movie")
    @unfollowed_directors = []
    directors.each do |creator|
      @unfollowed_directors.push creator if creator.users.where(id: current_user).empty?
    end
  end

  # -------------Create followed creator (any category)-----------------
  def create_followed_creator
    FollowedCreator.create(creator_id: params[:creator_id], user_id: current_user.id)
    redirect_back(fallback_location: root_path)
  end

  private

  def creator_params
    params.require(:followed_creator).permit(:creator)
  end
end
