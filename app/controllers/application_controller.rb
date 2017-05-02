class ApplicationController < ActionController::API

  private

  # TODO: have this information encrpyted in a token
  def authenticated_user
    User.where(email: email_from_headers, password: password_from_headers).first
  end

  def authenticated_superuser
    User.where(
      email: email_from_headers,
      password: password_from_headers,
      superuser: true
    )
  end

  def authenticate_account(account_id)
    Account.find(account_id).user.id == authenticated_user.id
  end

  def json_api_error(error_info = {})
    error = Error.new(error_info[:details], error_info[:status])
    render json: error
  end

  def account_not_found
    json_api_error(details: 'no account found', status: 404) && return
  end

  def email_from_headers
    creds[0]
  end

  def password_from_headers
    creds[1]
  end

  def creds
    Base64.decode64(request.headers['Authorization']).split(':')
  end
end
