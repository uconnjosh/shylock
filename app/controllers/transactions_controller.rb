class TransactionsController < ApplicationController
  def create
    return 403 unless transaction_approved

    Transaction.create(transaction_params.merge(account_id: account_id))
  end

private

  def transaction_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(params, only: [:amount, :for ])
  end

  def account_id
    # hard coded for now, will come from session later
    12
  end

  def account
    @account ||= Account.find(account_id)
  end

  def transaction_approved
    account.balance >= transaction_params[:amount]
  end
end
