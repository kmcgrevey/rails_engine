require 'rails_helper'

describe "Items API" do
  it "sends an index of items" do
    merchant = create(:merchant)
    create_list(:item, 3, merchant_id: merchant.id)

    get '/api/v1/items'
    
    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items["data"].count).to eq(3)
    expect(items["data"].first["attributes"]["name"].class).to eq(String)
  end
end