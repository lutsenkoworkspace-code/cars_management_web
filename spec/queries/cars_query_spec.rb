require 'rails_helper'

RSpec.describe CarsQuery do
  let!(:car_toyota) { create(:car, make: "Toyota", model: "Corolla", color: "Red", price: 15_000, year: 2015, odometer: 100_000, created_at: 1.day.ago) }
  let!(:car_bmw) { create(:car, make: "BMW", model: "X5", color: "Black", price: 50_000, year: 2021, odometer: 30_000, created_at: 2.days.ago) }
  let!(:car_ford) { create(:car, make: "Ford", model: "Mustang", color: "Red", price: 30_000, year: 2018, odometer: 60_000, created_at: 3.days.ago) }

  describe "#call" do
    it "returns all cars ordered by newest if no params are applied" do
      query = CarsQuery.new({})
      results = query.call
      expect(results.to_a).to eq([car_toyota, car_bmw, car_ford])
    end

    it "filters by make (case insensitive partial match)" do
      query = CarsQuery.new(make: "toy")
      expect(query.call).to contain_exactly(car_toyota)
    end

    it "filters by model (case insensitive partial match)" do
      query = CarsQuery.new(model: "x5")
      expect(query.call).to contain_exactly(car_bmw)
    end

    it "filters by color (case insensitive partial match)" do
      query = CarsQuery.new(color: "red")
      expect(query.call).to contain_exactly(car_toyota, car_ford)
    end

    it "filters by price range" do
      query = CarsQuery.new(min_price: 20_000, max_price: 60_000)
      expect(query.call).to contain_exactly(car_bmw, car_ford)
    end

    it "filters by year range" do
      query = CarsQuery.new(year_from: 2016, year_to: 2022)
      expect(query.call).to contain_exactly(car_bmw, car_ford)
    end

    it "filters by mileage range" do
      query = CarsQuery.new(min_mileage: 50_000, max_mileage: 150_000)
      expect(query.call).to contain_exactly(car_toyota, car_ford)
    end

    describe "sorting" do
      it "sorts by price_asc" do
        query = CarsQuery.new(sort: "price_asc")
        expect(query.call.to_a).to eq([car_toyota, car_ford, car_bmw])
      end

      it "sorts by price_desc" do
        query = CarsQuery.new(sort: "price_desc")
        expect(query.call.to_a).to eq([car_bmw, car_ford, car_toyota])
      end

      it "sorts by newest explicitly" do
        query = CarsQuery.new(sort: "newest")
        expect(query.call.to_a).to eq([car_toyota, car_bmw, car_ford])
      end
    end
  end
end
