require 'rails_helper'

RSpec.describe "Cars", type: :request do
  let!(:car) { create(:car) }
  let(:admin) { create(:user, :admin) }

  describe "GET /cars" do
    it "returns http success" do
      get cars_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /cars/:id" do
    it "returns http success" do
      get car_path(car)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /cars/new" do
    before { sign_in admin }

    it "returns http success" do
      get new_car_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /cars" do
    before { sign_in admin }

    it "creates a car and redirects" do
      expect {
        post cars_path, params: { car: attributes_for(:car) }
      }.to change(Car, :count).by(1)
      expect(response).to redirect_to(car_path(Car.last))
    end
  end

  describe "DELETE /cars/:id" do
    before { sign_in admin }

    it "destroys the car" do
      expect {
        delete car_path(car)
      }.to change(Car, :count).by(-1)
      expect(response).to redirect_to(cars_path)
    end
  end
end
