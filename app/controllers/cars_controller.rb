class CarsController < ApplicationController
  before_action :set_car, only: %i[show edit update destroy]

  def index
    @cars = CarsQuery.new(params).call
              .page(params[:page])
              .per(10)

    @total_count = @cars.total_count
  end

  def new
    @car = Car.new
  end

  def create
    @car = Car.new(car_params)

    if @car.save
      redirect_to car_path(@car), notice: t("cars.messages.created")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show; end
  def edit; end

  def update
    if @car.update(car_params)
      redirect_to car_path(@car), notice: t("cars.messages.updated")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @car.destroy
    redirect_to cars_path, notice: t("cars.messages.deleted"), status: :see_other
  end

  def search_page
    @searched = params.keys.any? { |k| %w[make model min_price max_price year_from year_to min_mileage max_mileage ].include?(k) }

    if @searched
      @cars = CarsQuery.new(params).call
                      .page(params[:page])
                      .per(10)
      @total_count = @cars.total_count
    else
      @cars = Car.none
    end
  end

  private

  def set_car
    @car = Car.find(params[:id])
  end

  def car_params
    params.require(:car).permit(:make, :model, :year, :odometer, :price, :description, :date_added, :color)
  end
end
