class AccountSerializer < ActiveModel::Serializer
  attributes :apr, :credit_limit, :open_date, :user_id, :balance

  has_many :statements
  has_many :transactions
end
