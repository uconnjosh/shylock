class RemoveCreditLimitFromAccount < ActiveRecord::Migration[5.0]
  def change
    remove_column :accounts, :credit_limit
  end
end
