require 'rails_helper'

describe "Search for mulitple Merchants" do
  it "locates by partial string of an attribute" do
    merchant1 = Merchant.create(name: "Boogers")
    merchant2 = Merchant.create(name: "Bobbers")
    merchant3 = Merchant.create(name: "Hello Kitboo")
    merchant4 = Merchant.create(name: "Big Kaboom")

    get '/api/v1/merchants/find_all?name=boo'

    expect(response).to be_successful

    resp = JSON.parse(response.body)

    expect(resp['data'].count).to eq(3)
    expect(resp['data'].class).to eq(Array)
  end
end