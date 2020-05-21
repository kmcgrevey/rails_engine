require 'rails_helper'

describe "Search for single Merchant" do
  it "locates by partial string of an attribute" do
    merchant1 = Merchant.create(name: "Boogers")
    merchant2 = Merchant.create(name: "Bobbers")

    get '/api/v1/merchants/find?name=boo'

    expect(response).to be_successful

    resp = JSON.parse(response.body)
  
    expect(resp['data']['attributes']['name']).to eq(merchant1.name)
  end
end