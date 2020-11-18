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
      rev = Merchant.revenue(merchant.id)[0].merch_rev
      
      expect(rev).to eq(inv_item.quantity * inv_item.unit_price)

      inv_item = InvoiceItem.last
      merchant = inv_item.invoice.merchant
      rev = Merchant.revenue(merchant.id)[0].merch_rev

      expect(rev).to eq(inv_item.quantity * inv_item.unit_price)
    end

    it '.most_revenue' do
      top_one = Merchant.most_revenue(1)
      top_two = Merchant.most_revenue(2)
      
      expect(top_one[1]).to eq(nil)
      expect(top_two[2]).to eq(nil)
      expect(top_two[0]).to eq(top_one[0])
      expect(Merchant.revenue(top_two[0].id)[0].merch_rev)
        .to be > (Merchant.revenue(top_two[1].id)[0].merch_rev)
    end
  end
end
