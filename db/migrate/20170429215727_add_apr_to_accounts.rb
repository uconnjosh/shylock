class AddAprToAccounts < ActiveRecord::Migration[5.0]
  def change
    add_column :accounts, :apr, :decimal, :precision => 4, :scale => 4
  end
end
