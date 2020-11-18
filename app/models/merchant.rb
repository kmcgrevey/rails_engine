class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoices, dependent: :destroy
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices

  def self.revenue(id)
    select('merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS merch_rev')
    .joins(:invoice_items, :transactions)
    .merge(Transaction.successful)
    .where("merchants.id = #{id}")
    .group(:id)
  end

  def self.most_revenue(quantity)
    select('merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS most_rev')
    .joins(:invoice_items, :transactions)
    .merge(Transaction.successful)
    .group('merchants.id')
    .order('most_rev desc')
    .limit(quantity)
  end
end