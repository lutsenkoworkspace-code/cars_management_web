class CarsController < ApplicationController
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
      redirect_to cars_path, notice: "Car was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @car = Car.find(params[:id])
  end

  def destroy
    @car = Car.find(params[:id])
    @car.destroy
    redirect_to cars_path, notice: "Car was successfully deleted.", status: :see_other
  end

  private

  def car_params
    params.require(:car).permit(:make, :model, :year, :odometer, :price, :description, :date_added)
  end
end
