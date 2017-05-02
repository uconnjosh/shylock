class Account < ApplicationRecord
  belongs_to :user
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

  def self.ids_where_statement_due
    # return account ids where the last statement is greater than 30 days old
    query = <<-SQL
      SELECT a.id
      FROM accounts a
      JOIN statements s1 on (a.id = s1.account_id)
      LEFT OUTER JOIN statements s2 on a.id = s2.account_id AND (s1.id < s2.id)
      WHERE s2.id IS NULL AND s1.created_at <= (now() - interval '30 days')
    SQL

    result = ActiveRecord::Base.connection.exec_query(query).rows.flatten
  end
end
