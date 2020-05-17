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
end