class AddCreditLimitBackToAccount < ActiveRecord::Migration[5.0]
  def change
    add_column :accounts, :credit_limit, :decimal, :precision => 18, :scale => 2
  end
end
