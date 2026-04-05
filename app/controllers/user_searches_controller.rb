class UserSearchesController < ApplicationController
  before_action :authenticate_user!

  def index
    @user_searches = current_user.user_searches.order(created_at: :desc)
  end

  def create
    final_params = user_search_params
    if params[:query_params].present?
      begin
        decoded_params = JSON.parse(params[:query_params])
        final_params = final_params.merge(query_params: decoded_params.reject { |_, v| v.blank? })
      rescue JSON::ParserError
        final_params = final_params.merge(query_params: {})
      end
    end

    @user_search = current_user.user_searches.build(final_params)

    if @user_search.save
      redirect_to user_searches_path, notice: t("user_searches.messages.created")
    else
      redirect_back fallback_location: search_page_path, alert: t("user_searches.messages.error")
    end
  end

  def destroy
    @user_search = current_user.user_searches.find(params[:id])
    @user_search.destroy
    redirect_to user_searches_path, notice: t("user_searches.messages.deleted")
  end

  private

  def user_search_params
    params.require(:user_search).permit(:name)
  end
end
