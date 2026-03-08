class CreateCars < ActiveRecord::Migration[8.1]
  def change
    create_table :cars do |t|
      t.string :make
      t.string :model
      t.integer :year
      t.integer :odometer
      t.decimal :price, precision: 12, scale: 2
      t.text :description
      t.date :date_added

      t.timestamps
    end
  end
end
