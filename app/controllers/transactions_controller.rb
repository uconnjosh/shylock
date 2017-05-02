class TransactionsController < ApplicationController
  before_action :authorize_account

  def create
    approve_transaction

    transaction = Transaction.create(
      transaction_params.merge(account_id: account.id).except(:email, :password)
    )

    render json: transaction
  end

private

  def transaction_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(
      params,
      only: [:amount, :for, :account_id, :email, :password]
    )
  end

  def account
    @account ||= Account.find(transaction_params[:account_id])
  end

  def insuficient_credit
    json_api_error(details: 'insuficient credit', status: 403) && return
  end

  def approve_transaction
    insuficient_credit unless account.balance >= transaction_params[:amount]
  end

  def authorize_account
    account_not_found unless authenticate_account(account.id)
  end
end
