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

    it "can get one item by its id" do
    merchant = create(:merchant)
    item1 = create(:item, merchant_id: merchant.id)
    item2 = create(:item, merchant_id: merchant.id)

    get "/api/v1/items/#{item1.id}"

    item = JSON.parse(response.body)

    expect(response).to be_successful

    expect(item["data"]["attributes"]["id"]).to eq(item1.id)
    expect(item["data"]["attributes"]["name"]).to_not eq(item2.name)
  end

  it "can create a new item" do
    merchant = create(:merchant)
    body = { "name": "Machete",
             "description": "Cuts like a knife and it feels so right.",
             "unit_price": 49.99,
             "merchant_id": "#{merchant.id}" }

    expect{ post '/api/v1/items', params: body }.to change(Item, :count).by(1)
    
    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item["data"]["attributes"]["name"]).to eq(body[:name])
  end

  it "can update an existing item" do
    merchant = create(:merchant)
    item1 = create(:item, merchant_id: merchant.id)

    previous_name = Item.last.name
    previous_price = Item.last.unit_price
    body_params = { "name": "Sledge",
                    "unit_price": 33.33 }

    put "/api/v1/items/#{item1.id}", params: body_params

    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item["data"]["attributes"]["name"]).not_to eq(previous_name)
    expect(item["data"]["attributes"]["name"]).to eq("Sledge")
    expect(item["data"]["attributes"]["unit_price"]).not_to eq(previous_price)
    expect(item["data"]["attributes"]["unit_price"]).to eq("33.33")
  end

  it "can destroy an item" do
   merchant = create(:merchant)
    item1 = create(:item, merchant_id: merchant.id)
    item2 = create(:item, merchant_id: merchant.id)

    expect(Item.count).to eq(2)

    delete "/api/v1/items/#{item1.id}"

    expect(Item.count).to eq(1)
    expect{Item.find(item1.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
end