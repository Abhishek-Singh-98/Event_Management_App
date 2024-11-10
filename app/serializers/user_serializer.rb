class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :contact_number, :user_type
end
