# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  auth_token      :string
#  email           :string
#  password_digest :string
#  username        :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_username  (username)
#
class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :email, :username, :created_at, :updated_at
  has_many :urls

  cache_options enabled: true, cache_length: 12.hours
end
