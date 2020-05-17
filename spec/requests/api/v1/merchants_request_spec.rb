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

  it "can create a new merchant" do
    body = { "name": "McDuffy's" }

    expect{ post '/api/v1/merchants', params: body }.to change(Merchant, :count).by(1)
    
    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["data"]["attributes"]["name"]).to eq(body[:name])
  end

  it "can update an existing merchant" do
    id = create(:merchant).id
    previous_name = Merchant.last.name
    body_params = { "name": "Sledge" }

    put "/api/v1/merchants/#{id}", params: body_params

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["data"]["attributes"]["name"]).not_to eq(previous_name)
    expect(merchant["data"]["attributes"]["name"]).to eq("Sledge")
  end
end