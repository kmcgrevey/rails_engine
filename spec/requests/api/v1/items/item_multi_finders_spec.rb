require 'rails_helper'

RSpec.describe 'Search for multiple Items', type: :request do
  before(:each) do
    merchant = create(:merchant)
    # create_list(:item, 3, merchant_id: merchant.id)
    @item1 = create(:item,
                    merchant_id: merchant.id,
                    name: "Inkpenny",
                    description: "I'm blue")
    @item2 = create(:item,
                    merchant_id: merchant.id,
                    name: "Ink Pen",
                    description: "I'm green")
    @item3 = create(:item,
                    merchant_id: merchant.id,
                    name: "Pencil",
                    description: "Get the lead out!")
    @item4 = create(:item,
                    merchant_id: merchant.id,
                    name: "Mask",
                    description: "Guess who?")
  end

  it 'returns a list by partial string search' do
    get '/api/v1/items/find_by?name=pen'

    expect(response).to be_successful

    resp = JSON.parse(response.body)

    expect(resp['data'].length).to eq(3)
    expect(resp['data']).to_not include(@item4)
  end
end