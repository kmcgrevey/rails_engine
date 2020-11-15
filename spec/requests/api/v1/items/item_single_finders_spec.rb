require 'rails_helper'

RSpec.describe 'Search for single Item', type: :request do
  before(:each) do
    merchant = create(:merchant)
    create_list(:item, 3, merchant_id: merchant.id)
    @item1 = create(:item,
                    merchant_id: merchant.id,
                    name: "Ink Pen")

  end
  
  it 'locates by partial string of an attribute' do
    binding.pry
    get '/api/v1/items/find?name=pen'

    expect(response).to be_successful

    resp = JSON.parse(response.body)

    expect(resp['data']['attributes']['id']).to eq(@item1.id)
  end
end