class SavedSearchesController < ApplicationController
  before_action :authenticate_user!

  def index
    @saved_searches = current_user.saved_searches.order(created_at: :desc)
  end

  def create
    final_params = saved_search_params
    if params[:query_params].present?
      begin
        decoded_params = JSON.parse(params[:query_params])
        final_params = final_params.merge(query_params: decoded_params.reject { |_, v| v.blank? })
      rescue JSON::ParserError
        final_params = final_params.merge(query_params: {})
      end
    end

    @saved_search = current_user.saved_searches.build(final_params)

    if @saved_search.save
      redirect_to saved_searches_path, notice: t("saved_searches.messages.created")
    else
      redirect_back fallback_location: search_page_path, alert: t("saved_searches.messages.error")
    end
  end

  def destroy
    @saved_search = current_user.saved_searches.find(params[:id])
    @saved_search.destroy
    redirect_to saved_searches_path, notice: t("saved_searches.messages.deleted")
  end

  private

  def saved_search_params
    params.require(:saved_search).permit(:name)
  end
end
