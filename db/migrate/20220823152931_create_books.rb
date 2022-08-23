class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :name
      t.date :release_date
      t.string :description
      t.references :creator, null: false, foreign_key: true

      t.timestamps
    end
  end
end
