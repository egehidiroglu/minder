class AddFieldsToConcerts < ActiveRecord::Migration[7.0]
  def change
    add_column :concerts, :poster_url, :string
    add_column :concerts, :event_url, :string
  end
end
