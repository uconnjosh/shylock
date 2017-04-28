class CreateStatements < ActiveRecord::Migration[5.0]
  def change
    create_table :statements do |t|
      t.date :begin_date
      t.date :end_date
      t.float :beginning_balance
      t.float :ending_balance
      t.float :interest_charged
      t.integer :account_id

      t.timestamps
    end
  end
end
