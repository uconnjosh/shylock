class AccountSerializer < ActiveModel::Serializer
  attributes :email, :apr, :credit_limit, :open_date, :user_id
end
