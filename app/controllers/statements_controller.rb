class StatementsController < ApplicationController
  def create

    if interest_due > 0
      charge_interest
    end

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

  def account
    @account ||= Account.find(account_id)
  end

  def beginning_balance
    account.balance(begin_date)
  end

  def ending_balance
    account.balance(end_date)
  end

  def interest_due
    return 0 unless ending_balance > 0

    account.statement_interest
  end

  def statement_period
    "#{begin_date}...#{end_date}"
  end

  def charge_interest
    Transaction.create(
      interest_charge: true,
      amount: interest_due,
      for: "Interest charge for statement period: #{statement_period}",
      account_id: account_id
    )
  end

private

  # def statement_params
  #   ActiveModelSerializers::Deserialization.jsonapi_parse(params, only: [:email, :"credit-limit", :"open-date", :apr ])
  # end

  # def account_id
  #   params[:id]
  # end
  def account_id
    12
  end
end
