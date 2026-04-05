class CarSearch
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :min_price, :integer
  attribute :max_price, :integer
  attribute :year_from, :integer
  attribute :year_to, :integer
  attribute :min_mileage, :integer
  attribute :max_mileage, :integer
  attribute :make, :string
  attribute :model, :string
  attribute :color, :string

  MIN_YEAR = 1900
  MAX_YEAR = Time.current.year + 1

  validates :min_price, :max_price, :min_mileage, :max_mileage,
            numericality: { greater_than_or_equal_to: 0, allow_nil: true }

  validates :year_from, :year_to,
            numericality: {
              greater_than_or_equal_to: MIN_YEAR,
              less_than_or_equal_to: MAX_YEAR,
              allow_nil: true
            }

  validate :range_logic

  private

  def range_logic
    errors.add(:min_price, :invalid) if min_price && max_price && min_price > max_price
    errors.add(:year_from, :invalid) if year_from && year_to && year_from > year_to
    errors.add(:min_mileage, :invalid) if min_mileage && max_mileage && min_mileage > max_mileage
  end
end
