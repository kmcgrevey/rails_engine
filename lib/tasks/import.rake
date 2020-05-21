require 'csv'

task :import => [:environment] do
  Merchant.destroy_all
  Customer.destroy_all
  Item.destroy_all
  Invoice.destroy_all
  InvoiceItem.destroy_all
  Transaction.destroy_all

  ActiveRecord::Base.connection.tables.each do |t|
    ActiveRecord::Base.connection.reset_pk_sequence!(t)
  end
  
  CSV.foreach('./data/merchants.csv', headers: :true).each do |row|
    Merchant.create( name: row['name'],
                      created_at: row['created_at'],
                      updated_at: row['updated_at'] )
  end

  CSV.foreach('./data/customers.csv', headers: :true).each do |row|
    Customer.create( first_name: row['first_name'],
                      last_name: row['last_name'],
                      created_at: row['created_at'],
                      updated_at: row['updated_at'] )
  end

  CSV.foreach('./data/items.csv', headers: :true).each do |row|
    Item.create( name: row['name'],
                  description: row['description'],
                  unit_price: row['unit_price'].to_f/100,
                  merchant_id: row['merchant_id'],
                  created_at: row['created_at'],
                  updated_at: row['updated_at'] )
  end

  CSV.foreach('./data/invoices.csv', headers: :true).each do |row|
    Invoice.create( customer_id: row['customer_id'],
                  merchant_id: row['merchant_id'],
                  status: row['status'],
                  created_at: row['created_at'],
                  updated_at: row['updated_at'] )
  end

  CSV.foreach('./data/invoice_items.csv', headers: :true).each do |row|
    InvoiceItem.create( item_id: row['item_id'],
                  invoice_id: row['invoice_id'],
                  quantity: row['quantity'],
                  unit_price: row['unit_price'].to_f/100,
                  created_at: row['created_at'],
                  updated_at: row['updated_at'] )
  end

  CSV.foreach('./data/transactions.csv', headers: :true).each do |row|
    Transaction.create( invoice_id: row['invoice_id'],
                  credit_card_number: row['credit_card_number'],
                  credit_card_expiration_date: row['credit_card_expiration_date'],
                  result: row['result'],
                  created_at: row['created_at'],
                  updated_at: row['updated_at'] )
  end

end
