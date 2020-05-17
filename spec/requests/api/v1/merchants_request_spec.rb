require 'rails_helper'

describe "Merchants API" do
  it "sends an index of merchants" do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants["data"].count).to eq(3)
    expect(merchants["data"].first["attributes"]["name"].class).to eq(String)
  end

  it "can get one item by its id" do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
   
    expect(merchant["data"]["id"]).to eq(id.to_s)
  end
end