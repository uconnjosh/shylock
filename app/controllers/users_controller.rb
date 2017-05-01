class UsersController < ApplicationController

  def show
    render json: user
  end

  def create
    User.create(user_params)
  end

  def update
    user.update_attributes(user_params)
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
    User.find(params[:id])
  end
end
