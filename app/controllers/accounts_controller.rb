class AccountsController < ApplicationController
  def create
    Account.create(account_params)
  end

  def update
    Account.find(account_id).update_attributes(account_params)
  end

private

  def account_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(params, only: [:email, :"credit-limit", :"open-date", :apr ])
  end

  def account_id
    params[:id]
  end
end
