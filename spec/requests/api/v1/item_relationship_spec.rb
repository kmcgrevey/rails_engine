require 'rails_helper'

describe "Item API Relationship" do
  it "returns merchant associated with an item" do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)

    get "/api/v1/items/#{item.id}/merchant"

    resp = JSON.parse(response.body)
    
    expect(resp['data']['attributes']['name']).to eq(merchant.name)
  end
end