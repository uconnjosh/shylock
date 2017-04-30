class ApplicationController < ActionController::API

  private

  # TODO: have this information encrpyted in a token
  def authenticate_account(account_id, email, password)
    account = Account.find(account_id)

    account.email = email && account.password = password
  end

  def json_api_error(error_info = {})
    error = Error.new(error_info[:details], error_info[:status])
    render json: error
  end
end
