module Mutations
  class UpdateUser < BaseMutation
    argument :email, String, required: false
    argument :username, String, required: false

    field :user, Types::UserType, null: true

    def execute(email: nil, username: nil)
      user = context[:current_user]
      UserUpdater.call(user, email: email, username: username)

      { user: user }
    end
  end
end
