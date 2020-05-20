class ChangeCreditCardNumberToBeStringInTransactions < ActiveRecord::Migration[5.1]
  def up
    change_column :transactions, :credit_card_number, :string
  end

  def down
    change_column :transactions, :credit_card_number, :integer
  end  
end
