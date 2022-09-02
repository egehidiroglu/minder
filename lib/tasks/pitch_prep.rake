namespace :pitch_prep do
  desc "Deleting all followed creators"
  task reset: :environment do
    puts "Destroying followed creators..."
    FollowedCreator.destroy_all
    puts "Destroying all favourites..."
    Favorite.destroy_all
    puts "Ege following everyone!"
    Creator.all.each do |creator|
      followed_creator = FollowedCreator.new
      followed_creator.user = User.all.first
      followed_creator.creator = creator
      followed_creator.save
    end
  end
end
