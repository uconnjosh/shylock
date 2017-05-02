class AccountsController < ApplicationController
  before_action :authorize_superuser, only: [:create, :update]
  before_action :authorize_account_owner, only: :show

  def show
    authorize_account_owner

    render json: account
  end

  def create
    # only superusers can open new credit accounts
    authorize_superuser
    account =
      Account.create(account_params.merge(user_id: related_user[:id]))

    Statement.create(account_id: account.id)

    render json: account
  end

  def update
    authorize_account_owner

    account.update_attributes(account_params)

    render json: account
  end

private

  def account_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(
      params,
      only: [:email, :password, :"credit-limit", :"open-date", :apr]
    )
  end

  def account
    @account ||= Account.find(params[:id])
  end

  def related_user
    user_data = params[:relationships][:user]

    ActiveModelSerializers::Deserialization.jsonapi_parse(user_data, only: :id)
  end

  def authorize_account_owner
    account_not_found unless
      authenticate_account(params[:id])
  end

  def authorize_superuser
    account_not_found unless authenticated_superuser
  end
end
