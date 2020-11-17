class MerchantSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :id, :merch_rev
  has_many :items
end
