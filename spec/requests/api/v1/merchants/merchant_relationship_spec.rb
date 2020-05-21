require 'rails_helper'

describe "Merchants API Relationship" do
  it "returns all items associated with a merchant" do
    merchant = create(:merchant)
    merchant2 = create(:merchant)
    create_list(:item, 3, merchant_id: merchant.id)
    item = create(:item, merchant_id: merchant2.id)

    get "/api/v1/merchants/#{merchant.id}/items"

    resp = JSON.parse(response.body)

    expect(resp['data'].count).to eq(3)
  end
end