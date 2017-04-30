class TransactionsController < ApplicationController
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

  def account_not_found
    json_api_error(details: 'no account found', status: 404) && return
  end

  def insuficient_credit
    json_api_error(details: 'insuficient credit', status: 403) && return
  end

  def approve_transaction
    account_not_found unless
      authenticate_account(
        account.id,
        transaction_params[:email],
        transaction_params[:password]
      )

    insuficient_credit unless account.balance >= transaction_params[:amount]
  end
end
