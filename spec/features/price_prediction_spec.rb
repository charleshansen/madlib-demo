require 'spec_helper'
require 'capybara/rails'

feature 'Price Prediction' do
  scenario 'predicting housing prices' do
    visit '/'

    fill_in 'house[tax]', with: 1000
    fill_in 'house[bedroom]', with: 2
    fill_in 'house[bath]', with: 2
    fill_in 'house[size]', with: 1000

    click_button 'Predict Price'

    page.should have_content '$92873'
  end
end
