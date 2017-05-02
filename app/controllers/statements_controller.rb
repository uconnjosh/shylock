class StatementsController < ApplicationController
  def show
    authorize_account_owner
  end

private

  def authorize_account_owner
    account_not_found unless
      authenticate_account(params[:id])
  end

  def account
    @account ||= statement_params[:account]
  end

  def statement_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(
      params,
      only: [:account_id]
    )
  end
end
