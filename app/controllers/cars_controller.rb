class CarsController < ApplicationController
  before_action :set_car, only: [ :show, :edit, :update, :destroy ]
  def index
    sort_logic = {
      "price_asc"  => { column: "price", direction: "asc" },
      "price_desc" => { column: "price", direction: "desc" },
      "newest"     => { column: "created_at", direction: "desc" }
    }

    selection = sort_logic[params[:sort]] || sort_logic["newest"]

    @cars = Car.order("#{selection[:column]} #{selection[:direction]}")
              .page(params[:page])
              .per(10)

    @total_count = Car.count
  end

  def new
    @car = Car.new
  end

  def create
    @car = Car.new(car_params)

    if @car.save
      redirect_to cars_path(@car, locale: I18n.locale), notice: t("cars.messages.created")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @car
  end

  def edit
    @car
  end

  def update
    if @car.update(car_params)
      redirect_to car_path(@car, locale: I18n.locale), notice: t("cars.messages.updated")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @car.destroy
    redirect_to cars_path, notice: t("cars.messages.deleted"), status: :see_other
  end

  private

  def set_car
    @car = Car.find(params[:id])
  end

  def car_params
    params.require(:car).permit(:make, :model, :year, :odometer, :price, :description, :date_added, :color)
  end
end
