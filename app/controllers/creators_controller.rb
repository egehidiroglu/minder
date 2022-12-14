class CreatorsController < ApplicationController
  def my_creators
    followed_creators = current_user.creators
    filter_params = ["All", "Music", "Book", "Movie"]
    if params[:query].present?
      if filter_params.include?(params[:query])
        case params[:query]
        when "All"
          @creators = []
          followed_creators.each do |followed|
            @creators.push(followed)
          end
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
        sql_query = <<~SQL
          creators.name ILIKE :query
        SQL
        to_compare = Creator.where(sql_query, query: "%#{params[:query]}%")
        @creators = []
        to_compare.each do |creator|
          @creators.push(creator) if current_user.creators.include?(creator)
        end
      end
    else
      @creators = current_user.creators
    end
  end

  def new
    @followed_creator = FollowedCreator.new
    all_creators = Creator.all
    my_creators = current_user.creators
    unfollowed_creators = all_creators - my_creators
    filter_params = ["All", "Music", "Book", "Movie"]
    if params[:query].present?
      if filter_params.include?(params[:query])
        case params[:query]
        when "All"
          @creators = []
          my_creators.each do |creator|
            @creators.push(creator)
          end
        when "Music"
          @creators = []
          unfollowed_creators.each do |creator|
            @creators.push(creator) if creator.content_type == "Music"
          end
        when "Book"
          @creators = []
          unfollowed_creators.each do |creator|
            @creators.push(creator) if creator.content_type == "Book"
          end
        when "Movie"
          @creators = []
          unfollowed_creators.each do |creator|
            @creators.push(creator) if creator.content_type == "Movie"
          end
        end
      else
        sql_query = <<~SQL
          creators.name ILIKE :query
        SQL
        to_compare = Creator.where(sql_query, query: "%#{params[:query]}%")
        @creators = []
        to_compare.each do |creator|
          @creators.push(creator) unless current_user.creators.include?(creator)
        end
      end
    else
      @creators = unfollowed_creators
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
    @creator = FollowedCreator.where(creator_id: params[:id], user_id: current_user.id).first
    @creator.destroy
  end

  # ----------------First time user signs in - choose artists-------------------
  def artist_setup
    artists = Creator.where(content_type: "Music")
    @unfollowed_artists = []
    artists.each do |creator|
      @unfollowed_artists.push creator if creator.users.where(id: current_user).empty?
    end
  end

  # ----------------First time user signs in - choose authors------------------

  def author_setup
    authors = Creator.where(content_type: "Book")
    @unfollowed_authors = []
    authors.each do |creator|
      @unfollowed_authors.push creator if creator.users.where(id: current_user).empty?
    end
  end

  # ----------------First time user signs in - choose directors-------------------
  def director_setup
    directors = Creator.where(content_type: "Movie")
    @unfollowed_directors = []
    directors.each do |creator|
      @unfollowed_directors.push creator if creator.users.where(id: current_user).empty?
    end
  end

  # -------------Create followed creator (any category)-------------------------
  def create_followed_creator
    FollowedCreator.create(creator_id: params[:creator_id], user_id: current_user.id)
    redirect_back(fallback_location: root_path)
  end

  # -------------Follow someone new, filters based on selection---------------
  def create_followed_creator_ajax
    puts "params #{params}"
    user = FollowedCreator.new(creator_id: params[:creator_id], user_id: current_user.id)
    puts user
    user.save
    respond_to do |format|
      format.html { user }
      format.json { render json: user }
    end
  end

  private

  def creator_params
    params.require(:followed_creator).permit(:creator)
  end
end
