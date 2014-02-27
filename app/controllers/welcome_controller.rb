class WelcomeController < ApplicationController
  def index
    redirect_to :housing_prices
  end
end
