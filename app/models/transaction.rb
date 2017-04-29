class Transaction < ApplicationRecord
  belongs_to :account
  belongs_to :statement

  scope :principle, -> { where('interest_charge IS NULL OR interest_charge = false') }

  def new_balance
    account.balance
  end
end
