require 'rails_helper'

RSpec.describe 'BI Endpoint', type: :request do
    before(:each) do
    inv_items = create_list(:invoice_item, 5)
    inv_items.each do |item|
      item.invoice.transactions.create(
        result: 'success')
    end
  end
  
  it 'lists Merchants with Most Revenue limit to qty requested' do
    get '/api/v1/merchants/most_revenue?quantity=3'
    expect(response).to be_successful
    
    resp = JSON.parse(response.body)
    
    expect(resp.count).to eq(3)
  end
end