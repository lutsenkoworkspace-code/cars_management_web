require 'rails_helper'

RSpec.describe User, type: :model do
  describe "associations" do
    it "has many user_searches" do
      assoc = described_class.reflect_on_association(:user_searches)
      expect(assoc.macro).to eq :has_many
    end
  end

  describe "methods" do
    describe "#full_name" do
      it "returns the full_name attribute" do
        user = build(:user, full_name: "John Doe")
        expect(user.full_name).to eq("John Doe")
      end

      it "falls back to email name if full_name is undefined" do
        user = build(:user, full_name: nil, email: "johndoe@example.com")
        expect(user.full_name).to be_nil
      end
    end
  end

  describe "roles" do
    it "defaults to user role" do
      user = build(:user)
      expect(user.role).to eq("user")
    end

    it "can be an admin" do
      user = build(:user, :admin)
      expect(user.role).to eq("admin")
      expect(user.admin?).to be true
    end
  end
end
