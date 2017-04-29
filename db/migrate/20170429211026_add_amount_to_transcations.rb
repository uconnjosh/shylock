class AddAmountToTranscations < ActiveRecord::Migration[5.0]
  def change
    add_column :transactions, :amount, :decimal, :precision => 18, :scale => 2
  end
end
