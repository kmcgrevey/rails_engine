class CreateInvoices < ActiveRecord::Migration[5.1]
  def change
    create_table :invoices do |t|
      t.references :customer, foreign_key: true
      t.references :merchant, foreign_key: true
      t.string :status
      t.string :created_at
      t.string :updated_at

      t.timestamps
    end
  end
end
