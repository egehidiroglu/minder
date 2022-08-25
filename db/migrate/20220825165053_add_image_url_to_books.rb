class AddImageUrlToBooks < ActiveRecord::Migration[7.0]
  def change
    add_column :books, :poster_url, :string
  end
end
