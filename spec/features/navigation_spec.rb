require 'spec_helper'

feature 'Navigating around the app' do
  scenario 'Switching between pages' do
    visit '/'

    click_on 'Add Data'
    page.current_path.should == '/add_housing_prices'

    click_on 'Run Predictions'
    page.current_path.should == '/housing_prices'
  end
end
