require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many :items }
    it { should have_many :invoices }
    it { should have_many(:invoice_items).through(:invoices)}
    it { should have_many(:transactions).through(:invoices)}
  end

  describe 'class methods' do
    before(:each) do
      inv_items = create_list(:invoice_item, 4)
      inv_items.each do |item|
        item.invoice.transactions.create(
          result: 'success')
      end
    end
    
    it '.revenue' do
      inv_item = InvoiceItem.first
      merchant = inv_item.invoice.merchant
      rev = Merchant.revenue(merchant.id)

      expect(rev).to eq(inv_item.quantity * inv_item.unit_price)
    end
  end
end
