class UserSerializer < ActiveModel::Serializer
  attributes :address, :email, :password, :phone
end
