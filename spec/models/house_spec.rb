require 'spec_helper'

describe House do
  before do
    `/usr/local/madlib/bin/madpack -p postgres -c pivotal@localhost:5432/madlib-demo_test install`
    `RAILS_ENV=test rake db:seed`
  end

  it 'can train price prediction' do
    House.train_price
    House.predict_price(tax: 590, bedroom: 2, bath: 1, size: 770).should == '63466.6938566'
  end
end