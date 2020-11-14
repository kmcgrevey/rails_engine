require 'rails_helper'

describe "Search for single Merchant" do
  before(:each) do
    @date1 = Time.new(2012, 03, 27, 14, 53, 59, "+00:00")
    @date2 = Time.new(2019, 11, 11, 02, 55, 30, "+00:00") # "2019-11-11 02:55:30"
    @date3 = Time.new(2020, 02, 20, 12, 30, 00, "+00:00")
    @merchant1 = Merchant.create!(name: "Boogers",
                                 created_at: @date1,
                                 updated_at: @date1)
    @merchant2 = Merchant.create!(name: "Bobbers",
                                created_at: @date2,
                                updated_at: @date3)
  end
  
  it "locates by partial string of an attribute" do
    get '/api/v1/merchants/find?name=boo'

    expect(response).to be_successful

    resp = JSON.parse(response.body)

    expect(resp['data']['attributes']['name']).to eq(@merchant1.name)
  end

  it "locates by timestamp" do
    get '/api/v1/merchants/find?created_at=2012-03-27'

    resp = JSON.parse(response.body)
    
    expect(resp['data']['attributes']['id']).to eq(@merchant1.id)

    get '/api/v1/merchants/find?updated_at=2020-02-20'

    resp = JSON.parse(response.body)
  
    expect(resp['data']['attributes']['id']).to eq(@merchant2.id)
  end
end