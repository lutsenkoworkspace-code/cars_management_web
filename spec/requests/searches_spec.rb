require 'rails_helper'

RSpec.describe "Searches", type: :request do
  describe "GET /search" do
    let!(:cheap_car) { create(:car, make: "Toyota", model: "Corolla", price: 10_000, year: 2010, odometer: 150_000) }
    let!(:expensive_car) { create(:car, make: "BMW", model: "X5", price: 50_000, year: 2020, odometer: 50_000) }

    it "renders the search page with no results initially if no params are given" do
      get search_page_path
      expect(response).to have_http_status(:success)
      expect(assigns(:cars)).to be_empty
      expect(assigns(:searched)).to be_falsey
    end

    it "returns results when valid params are provided under car_search key" do
      get search_page_path, params: { car_search: { min_price: 5000, max_price: 20000 } }
      expect(response).to have_http_status(:success)
      expect(assigns(:searched)).to be_truthy
      expect(assigns(:cars)).to include(cheap_car)
      expect(assigns(:cars)).not_to include(expensive_car)
    end

    it "returns empty results if search parameters are logically invalid" do
      get search_page_path, params: { car_search: { min_price: 50000, max_price: 10000 } }
      expect(response).to have_http_status(:success)
      expect(assigns(:cars)).to be_empty
      expect(assigns(:search).valid?).to be false
    end

    it "handles top-level query parameters parsing correctly" do
      get search_page_path, params: { make: "Toyota" }
      expect(response).to have_http_status(:success)
      expect(assigns(:searched)).to be_truthy
      expect(assigns(:cars)).to include(cheap_car)
      expect(assigns(:cars)).not_to include(expensive_car)
    end
  end
end
