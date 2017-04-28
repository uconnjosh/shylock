class TransactionsController < ApplicationController
  def create
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
end
