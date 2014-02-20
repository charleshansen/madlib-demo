require 'spec_helper'

describe House do
  it 'can train price prediction' do
    House.train_price
    House.predict_price(tax: 590, bedroom: 2, bath: 1, size: 770).should == '63466.6938566'
  end

  it 'returns the correct result after multiple trainings' do
    House.train_price
    House.train_price
    House.predict_price(tax: 590, bedroom: 2, bath: 1, size: 770).should == '63466.6938566'
  end
end