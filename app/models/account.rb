class Account < ApplicationRecord
  has_many :transactions

  def balance(day = DateTime.now, principle_only = false)
    return 0 if transactions.empty?

    balance_transactions =
      principle_only ? transactions.principle : transactions

    balance_transactions
      .where('created_at <= :day', day: day)
      .pluck(:amount).inject { |a, e| a + e } || 0
  end

  def statement_interest(days = 30)
    average_daily_balance * apr / 365 * days
  end

  def average_daily_balance(days = 30)
    summed_balance = 0

    days.times do |i|
      summed_balance += balance(i.days.ago, true)
    end

    summed_balance / days
  end
end
