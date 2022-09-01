namespace :pitch_prep do
  desc "Deleting all followed creators"
  task reset: :environment do
    puts "Destroying followed creators..."
    FollowedCreator.destroy_all
  end
end
