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
      @inv_item3 = create(:invoice_item,
                           quantity: 5,
                           unit_price: 0.500)
      @inv_item1 = create(:invoice_item,
                           quantity: 10,
                           unit_price: 0.900)
      @inv_item4 = create(:invoice_item,
                          quantity: 1,
                          unit_price: 0.100)
      @inv_item2 = create(:invoice_item,
                           quantity: 6,
                           unit_price: 0.600)
     
      InvoiceItem.all.each do |item|
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
      top_four = Merchant.most_revenue(4)

      merch1 = @inv_item1.invoice.merchant
      merch2 = @inv_item2.invoice.merchant
      merch3 = @inv_item3.invoice.merchant
      merch4 = @inv_item4.invoice.merchant

      merch1_rev = Merchant.revenue(merch1.id)[0].merch_rev
      merch2_rev = Merchant.revenue(merch2.id)[0].merch_rev
      merch3_rev = Merchant.revenue(merch3.id)[0].merch_rev
      merch4_rev = Merchant.revenue(merch4.id)[0].merch_rev
  
      expect(top_one[1]).to eq(nil)
      expect(top_two[2]).to eq(nil)
      expect(top_two[0]).to eq(top_one[0])
      expect(Merchant.revenue(top_two[0].id)[0].merch_rev)
        .to be > (Merchant.revenue(top_two[1].id)[0].merch_rev)
      expect(top_four).to eq([merch1, merch2, merch3, merch4])
      expect(merch1_rev).to be > (merch2_rev)
      expect(merch1_rev).to be > (merch4_rev)
    end
  end
end
