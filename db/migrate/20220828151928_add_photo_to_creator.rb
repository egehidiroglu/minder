class AddPhotoToCreator < ActiveRecord::Migration[7.0]
  def change
    add_column :creators, :poster_url, :string
  end
end
