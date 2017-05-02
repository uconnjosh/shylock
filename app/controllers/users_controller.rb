class UsersController < ApplicationController

  def show
    account_not_found unless
      authenticated_user

    render json: user
  end

  def create
    new_user = User.create(user_params)

    render json: new_user
  end

  def update
    user.update_attributes(user_params)

    render json: user
  end

  def destroy
    user.destroy
  end

private

  def user_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(
      params,
      only: [:email, :password, :address, :phone]
    )
  end

  def user
    @user ||= User.find(params[:id])
  end
end
