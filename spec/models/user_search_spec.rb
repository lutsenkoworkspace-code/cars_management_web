require 'rails_helper'

RSpec.describe UserSearch, type: :model do
  let(:user) { create(:user) }

  describe "validations" do
    it "is valid with a user and a name" do
      search = UserSearch.new(user: user, name: "Daily Search")
      expect(search).to be_valid
    end

    it "is invalid without a name" do
      search = UserSearch.new(user: user, name: nil)
      expect(search).to_not be_valid
      expect(search.errors[:name]).to be_present
    end

    it "is invalid without a user" do
      search = UserSearch.new(name: "My Search")
      expect(search).to_not be_valid
      expect(search.errors[:user]).to be_present
    end
  end

  describe "query_params serialization" do
    it "serializes and deserializes query_params as a hash" do
      search = UserSearch.create!(user: user, name: "Test", query_params: { "min_price" => "5000" })
      search.reload
      expect(search.query_params).to be_a(Hash)
      expect(search.query_params["min_price"]).to eq("5000")
    end
  end
end
