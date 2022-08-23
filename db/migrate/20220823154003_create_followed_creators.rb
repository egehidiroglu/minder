class CreateFollowedCreators < ActiveRecord::Migration[7.0]
  def change
    create_table :followed_creators do |t|
      t.references :creator, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
