class AddColorToCars < ActiveRecord::Migration[8.1]
  def change
    add_column :cars, :color, :string
  end
end
