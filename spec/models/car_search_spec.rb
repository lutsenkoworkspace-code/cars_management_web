require 'rails_helper'

RSpec.describe CarSearch, type: :model do
  describe "validations" do
    it "is valid with valid attributes" do
      search = CarSearch.new(min_price: 1000, max_price: 5000, year_from: 2010, year_to: 2020)
      expect(search).to be_valid
    end

    it "is valid when empty" do
      search = CarSearch.new
      expect(search).to be_valid
    end

    describe "range logic" do
      it "is invalid if min_price > max_price" do
        search = CarSearch.new(min_price: 5000, max_price: 1000)
        expect(search).to_not be_valid
        expect(search.errors[:min_price]).to be_present
      end

      it "is invalid if year_from > year_to" do
        search = CarSearch.new(year_from: 2020, year_to: 2010)
        expect(search).to_not be_valid
        expect(search.errors[:year_from]).to be_present
      end

      it "is invalid if min_mileage > max_mileage" do
        search = CarSearch.new(min_mileage: 150_000, max_mileage: 50_000)
        expect(search).to_not be_valid
        expect(search.errors[:min_mileage]).to be_present
      end
    end

    describe "numericality" do
      it "is invalid with negative numbers" do
        search = CarSearch.new(min_price: -100, min_mileage: -50)
        expect(search).to_not be_valid
        expect(search.errors[:min_price]).to be_present
        expect(search.errors[:min_mileage]).to be_present
      end

      it "is invalid with years out of range" do
        search = CarSearch.new(year_from: 1800, year_to: 3000)
        expect(search).to_not be_valid
        expect(search.errors[:year_from]).to be_present
        expect(search.errors[:year_to]).to be_present
      end
    end
  end

  describe "attributes" do
    it "correctly assigns string attributes" do
      search = CarSearch.new(make: "Toyota", model: "Camry", color: "Red")
      expect(search.make).to eq "Toyota"
      expect(search.model).to eq "Camry"
      expect(search.color).to eq "Red"
    end
  end
end
