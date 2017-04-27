class AccountsController < ApplicationController
  def create
    Account.create(account_create_params)
  end

private

  def account_create_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(params, only: [:email, :"credit-limit", :"open-date", :apr ])
  end
end
