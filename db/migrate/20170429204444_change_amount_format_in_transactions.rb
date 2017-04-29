class ChangeAmountFormatInTransactions < ActiveRecord::Migration[5.0]
  def change
    remove_column :transactions, :amount
  end
end
