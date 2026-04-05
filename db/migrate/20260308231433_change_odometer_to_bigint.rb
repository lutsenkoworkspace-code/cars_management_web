class ChangeOdometerToBigint < ActiveRecord::Migration[8.1]
  def change
    change_column :cars, :odometer, :bigint
  end
end
