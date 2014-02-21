class HouseController < ApplicationController
  def show
    @training_set_size = House.count
    render :show
  end

  def predict_price
    House.train_price
    @predicted_price = House.predict_price(params[:house])
    render :predicted_price
  end

  def gather_housing_data
    render :gather_housing_data
  end

  def create
    House.create(house_params)
  end

  private
  def house_params
    params.require(:house).permit(:tax, :bedroom, :bath, :price, :size, :lot)
  end
end