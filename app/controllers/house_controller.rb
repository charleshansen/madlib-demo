class HouseController < ApplicationController
  def show
    render :show
  end

  def predict_price
    House.train_price
    @predicted_price = House.predict_price(params[:house])
    render :predicted_price
  end

end