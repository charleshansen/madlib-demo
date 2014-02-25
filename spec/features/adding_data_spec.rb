require 'tempfile'
require 'spec_helper'
require 'capybara/rails'

feature 'Adding Data' do
  scenario 'adding more housing data to train on' do
    visit '/add_housing_prices'

    fill_in 'house[tax]', with: 1000
    fill_in 'house[bedroom]', with: 2
    fill_in 'house[bath]', with: 2
    fill_in 'house[price]', with: 200000
    fill_in 'house[size]', with: 1000
    fill_in 'house[lot]', with: 1000

    click_button 'Add House'

    page.should have_content 'You have successfully added this row of housing data. It will now be used to train housing prices.'

    visit '/housing_prices'

    page.should have_content 'Predicting housing price based on a training set with 16 data points.'
  end

  scenario 'user uploads a CSV file' do
    file = Tempfile.new('housing_data')

    begin
      File.open(file.path, 'w') do |csv|
        csv.write("tax,bedroom,bath,price,size,lot\n1000,2,2,100000,800,2\n1000,4,4,100000,800,4")
      end

      visit '/add_housing_prices'

      attach_file('csv_file', file.path)
      click_button 'Upload'

      visit '/housing_prices'

      page.should have_content 'Predicting housing price based on a training set with 17 data points.'
    ensure
      file.close
      file.unlink
    end
  end
end