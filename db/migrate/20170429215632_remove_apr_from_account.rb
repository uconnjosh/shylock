class RemoveAprFromAccount < ActiveRecord::Migration[5.0]
  def change
    remove_column :accounts, :apr
  end
end
