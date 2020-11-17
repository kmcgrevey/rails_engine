require 'rails_helper'

RSpec.describe 'BI Endpoint', type: :feature do
  before(:each) do
    inv_items = create_list(:invoice_item, 4)
    inv_items.each do |item|
      item.invoice.transactions.create(
        result: 'success')
    end
  end
  
  it 'Revenue for a Merchant' do
      inv_item = InvoiceItem.first
      merchant = inv_item.invoice.merchant

      get "/api/v1/merchants/#{merchant.id}/revenue"

      expect(response).to be_successful

      resp = JSON.parse(response.body)
      
      expect(resp['data']['attributes']['revenue'])
        .to eq(inv_item.quantity * inv_item.unit_price)
  end
end