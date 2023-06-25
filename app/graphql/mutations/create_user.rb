module Mutations
  class CreateUser < BaseMutation
    argument :email, String, required: true
    argument :username, String, required: true
    argument :password, String, required: true
    argument :password_confirmation, String, required: true

    field :user, Types::UserType, null: true

    def execute(email:, username:, password:, password_confirmation:)
      user = UserCreator.call(email: email, username: username, password: password, password_confirmation: password_confirmation)
      { user: user }
    end
  end
end
