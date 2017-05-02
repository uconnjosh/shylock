class Transaction < ApplicationRecord
  belongs_to :account
  belongs_to :statement

  scope :principle, -> { where('interest_charge IS NULL OR interest_charge = false') }

  def new_balance
    account.balance
  end

  def self.all_for_user(user_id)
    where("transactions.account_id = account_id AND accounts.user_id = #{user_id}").joins(:account)
  end

  def self.all_for_account(account_id)
    where(account_id: account_id)
  end
end

