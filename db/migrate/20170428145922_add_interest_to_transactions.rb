class AddInterestToTransactions < ActiveRecord::Migration[5.0]
  def change
    add_column :transactions, :interest_charge, :boolean
  end
end
