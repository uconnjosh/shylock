class Statement < ApplicationRecord
  belongs_to :account
  has_one :transaction
end
