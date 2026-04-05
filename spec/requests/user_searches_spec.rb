require 'rails_helper'

RSpec.describe "UserSearches", type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  describe "GET /user_searches" do
    it "redirects to login if not authenticated" do
      get user_searches_path
      expect(response).to redirect_to(new_user_session_path)
    end

    it "renders the index and assigns scoped user_searches if authenticated" do
      sign_in user
      my_search = create(:user_search, user: user, name: "My Toyota")
      other_search = create(:user_search, user: other_user, name: "Hidden")

      get user_searches_path
      expect(response).to have_http_status(:success)
      expect(assigns(:user_searches)).to include(my_search)
      expect(assigns(:user_searches)).not_to include(other_search)
    end
  end

  describe "POST /user_searches" do
    before { sign_in user }

    it "creates a user search gracefully parsing JSON query parameters" do
      expect {
        post user_searches_path, params: {
          user_search: { name: "Dream Car" },
          query_params: { make: "BMW", min_price: "20000" }.to_json
        }
      }.to change(UserSearch, :count).by(1)

      expect(response).to redirect_to(user_searches_path)
      search = UserSearch.last
      expect(search.name).to eq("Dream Car")
      expect(search.query_params["make"]).to eq("BMW")
    end

    it "handles malformed JSON gracefully by ignoring query_params" do
      expect {
        post user_searches_path, params: {
          user_search: { name: "Broken Search" },
          query_params: "invalid_json_str["
        }
      }.to change(UserSearch, :count).by(1)

      search = UserSearch.last
      expect(search.query_params).to eq({})
    end

    it "redirects back with alert if user_search save validation fails" do
      expect {
        post user_searches_path, params: { user_search: { name: "" } }
      }.not_to change(UserSearch, :count)

      expect(response).to redirect_to(search_page_path)
      expect(flash[:alert]).to eq(I18n.t("user_searches.messages.error"))
    end
  end

  describe "DELETE /user_searches/:id" do
    let!(:user_search) { create(:user_search, user: user, name: "To Delete") }

    before { sign_in user }

    it "destroys the specified user search" do
      expect {
        delete user_search_path(user_search)
      }.to change(UserSearch, :count).by(-1)

      expect(response).to redirect_to(user_searches_path)
      expect(flash[:notice]).to eq(I18n.t("user_searches.messages.deleted"))
    end

    it "cannot destroy another user's search due to user scoping" do
      other = create(:user_search, user: other_user)
      expect {
        delete user_search_path(other)
      }.not_to change(UserSearch, :count)

      expect(response).to have_http_status(:not_found)
    end
  end
end
