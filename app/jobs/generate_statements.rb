class GenerateStatements
  include Delayed::RecurringJob
  run_every 1.day
  run_at '7:40pm'
  timezone 'US/Pacific'
  queue 'slow-jobs'
  def perform
    generate_statements
  end

  def account_ids
  	query <<-SQL
  	  SELECT a.id
      FROM accounts a
      JOIN statements s1 on (a.id = s1.account_id)
      LEFT OUTER JOIN statements s2 on (a.id = s2.account_id AND (s1.created_at < s2.created_at OR s1.created_at = s2.created_at AND s1.id < s2.id))
      WHERE s2.id IS NULL;
    SQL

  	# Account.where("statements.last.created_at >= :date", date: DateTime.now - 30.days)
   #  query = <<-SQL
   #    accounts.statements.last

   #  Statement.where(
   #    'created_at >= :day',
   #    day: DateTime.now - 30.days
   #  ).pluck(:account_id).uniq
  end

  def genererate_statements
    account_ids.each do |a_id|
      @account = Account.find(a_id)
      generate_statement
    end
  end

  def generate_statement
    charge_interest if interest_due > 0

    statement = Statement.create(
      end_date: end_date,
      begin_date: begin_date,
      beginning_balance: beginning_balance,
      ending_balance: ending_balance,
      interest_charged: interest_due,
      account_id: account_id
    )

    render json: statement
  end

  def end_date
    @end_date ||= DateTime.now
  end

  def begin_date
    @begin_date ||= end_date - 30.days
  end

  def beginning_balance
    @account.balance(begin_date)
  end

  def ending_balance
    @account.balance(end_date)
  end

  def interest_due
    return 0 unless ending_balance > 0

    @account.statement_interest
  end

  def statement_period
    "#{begin_date}...#{end_date}"
  end

  def charge_interest
    Transaction.create(
      interest_charge: true,
      amount: interest_due,
      for: "Interest charge for statement period: #{statement_period}",
      account_id: @account.id
    )
  end
end
