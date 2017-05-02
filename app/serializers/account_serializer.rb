class AccountSerializer < ActiveModel::Serializer
  attributes :apr, :credit_limit, :open_date, :user_id

  has_many :statements
  has_many :transactions
end
