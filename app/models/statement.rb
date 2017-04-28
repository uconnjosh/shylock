class Statement < ApplicationRecord
  belongs_to :account
  has_one :interest_charge, foreign_key: 'statement_id', class_name: 'Transaction'
end
