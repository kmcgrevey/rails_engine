require 'rails_helper'

RSpec.describe 'Search for single Item', type: :request do
  before(:each) do
    merchant = create(:merchant)
    create_list(:item, 3, merchant_id: merchant.id)
    @item1 = create(:item,
                    merchant_id: merchant.id,
                    name: "Ink Penny",
                    description: "I'm blue")
    @item2 = create(:item,
                    merchant_id: merchant.id,
                    name: "Ink Pen",
                    description: "I'm green")

  end
  
  it 'locates by partial string of an attribute' do
    get '/api/v1/items/find?name=pen'
    
    expect(response).to be_successful
    
    resp = JSON.parse(response.body)
    
    expect(resp['data']['attributes']['id']).to eq(@item1.id)
    
    get '/api/v1/items/find?description=green'
    
    resp = JSON.parse(response.body)
    
    expect(resp['data']['attributes']['id']).to eq(@item2.id)
    expect(resp['data']['attributes']['id']).to_not eq(@item1.id)
  end
end