class GenerateStatements
  include Delayed::RecurringJob
  run_every 1.day
  run_at '7:40pm'
  timezone 'US/Pacific'
  queue 'slow-jobs'
  def perform
    generate_statements
  end

  def generate_statements
    Account.ids_where_statement_due.each do |a_id|
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
