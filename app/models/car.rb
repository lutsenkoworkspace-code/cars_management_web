class Car < ApplicationRecord
  validates :make, :model, :year, :odometer, :price, presence: true
  validates :year, numericality: { only_integer: true, greater_than: 1885 }
  validates :odometer, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :price, numericality: { greater_than_or_equal_to: 0 }
end
