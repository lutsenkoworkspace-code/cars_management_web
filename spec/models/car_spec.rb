require 'rails_helper'

RSpec.describe Car, type: :model do
  it "is valid with valid attributes" do
    expect(build(:car)).to be_valid
  end

  it "is invalid without a make" do
    car = build(:car, make: nil)
    expect(car).not_to be_valid
  end

  it "is invalid with a negative price" do
    car = build(:car, price: -1)
    expect(car).not_to be_valid
  end
end
