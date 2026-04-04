class SearchesController < ApplicationController
  def show
    @search = CarSearch.new(search_params_logic)
    @searched = params[:car_search].present? || params.keys.any? { |k| %w[make model year_from].include?(k) }

    if @searched
      if @search.valid?
        query_params = @search.attributes.merge(sort: params[:sort])
        @cars = CarsQuery.new(query_params).call
                        .page(params[:page])
                        .per(10)
        @total_count = @cars.total_count
      else
        @cars = Car.none
      end
    else
      @cars = Car.none
    end
  end

  private

  def search_params_logic
    if params[:car_search].present?
      params.require(:car_search).permit(:make, :model, :color, :min_price, :max_price, :year_from, :year_to, :min_mileage, :max_mileage)
    else
      params.permit(:make, :model, :color, :min_price, :max_price, :year_from, :year_to, :min_mileage, :max_mileage)
    end
  end
end
