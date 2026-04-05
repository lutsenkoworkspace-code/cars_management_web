class CarsController < ApplicationController
  before_action :set_car, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[index show]
  before_action :authorize_admin!, only: %i[new create edit update destroy]

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

  private

  def authorize_admin!
    unless current_user&.admin?
      redirect_to root_path, alert: t("errors.not_authorized", default: "You do not have permission to do this!")
    end
  end

  def set_car
    @car = Car.find(params[:id])
  end

  def car_params
    params.require(:car).permit(:make, :model, :year, :odometer, :price, :description, :date_added, :color)
  end
end
