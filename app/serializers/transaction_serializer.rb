class TransactionSerializer < ActiveModel::Serializer
  attributes :amount, :for, :currency, :new_balance
end
