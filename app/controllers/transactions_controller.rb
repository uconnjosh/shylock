class TransactionsController < ApplicationController
  before_action :authorize_account, only: [:create, :show]

  def create
    approve_transaction

    transaction = Transaction.create(
      transaction_params.merge(account_id: account.id)
    )

    render json: transaction
  end

  def show
    render json: transaction
  end

  def index
    transactions = Transaction.all_for_user(authenticated_user.id)

    render json: transactions, is_collection: true
  end

private

  def transaction
    @transaction ||= Transaction.find(params[:id])
  end

  def transaction_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(
      params,
      only: [:amount, :for, :id]
    )
  end

  def account_params
    account_data = params[:relationships][:account]

    ActiveModelSerializers::Deserialization.jsonapi_parse(account_data, only: :id)
  end

  def account
    @account ||=
      if params[:id]
        transaction.account
      else
        Account.find(account_params[:id])
      end
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
