class AddStatementToTransactions < ActiveRecord::Migration[5.0]
  def change
    add_column :transactions, :statement_id, :integer
  end
end
