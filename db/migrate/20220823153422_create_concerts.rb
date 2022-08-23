class CreateConcerts < ActiveRecord::Migration[7.0]
  def change
    create_table :concerts do |t|
      t.string :name
      t.date :date
      t.string :venue
      t.string :address
      t.references :creator, null: false, foreign_key: true

      t.timestamps
    end
  end
end
