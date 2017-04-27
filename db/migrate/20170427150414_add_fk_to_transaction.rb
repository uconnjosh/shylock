class AddFkToTransaction < ActiveRecord::Migration[5.0]
  def change
  	add_reference :transactions, :account, foreign_key: true
  end
end
