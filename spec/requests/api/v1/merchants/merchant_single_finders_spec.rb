require 'rails_helper'

describe "Search for single Merchant" do
  before(:each) do
    @merchant1 = Merchant.create(name: "Boogers",
                                 created_at: "2012-03-27 14:53:59",
                                 updated_at: "2012-03-27 14:53:59")
    @merchant2 = Merchant.create(name: "Bobbers",
                                created_at: "2019-11-11 02:55:30",
                                updated_at: "2020-02-20 12:30:00")
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

    expect(resp['data']['attributes']['created_at']).to eq(@merchant1.created_at)

    get '/api/v1/merchants/find?updated_at=2020-02-20'

    resp = JSON.parse(response.body)
    
    expect(resp['data']['attributes']['updated_at']).to eq(@merchant2.updated_at)
  end
end