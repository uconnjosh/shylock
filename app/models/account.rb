class Account < ApplicationRecord
  has_many :transactions

  def balance(day = DateTime.now)
    transactions.where("created_at <= :day", day: day).pluck(:amount).inject { |a, e| a.to_f + e.to_f }.to_f
  end

  def principle_balance(day = DateTime.now)
    transactions.principle.where("created_at <= :day", day: day).pluck(:amount).inject { |a, e| a.to_f + e.to_f }.to_f
  end

  def statement_interest(days = 30)
    average_daily_balance * apr.to_f/365 * days
  end

  def average_daily_balance(days = 30)
    summed_balance = 0

    days.times do |i|
      summed_balance += principle_balance(i.days.ago)
    end

    summed_balance / days
  end
end
