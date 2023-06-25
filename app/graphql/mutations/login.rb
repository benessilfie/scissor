module Mutations
  class Login < BaseMutation
    argument :email, String, required: true
    argument :password, String, required: true

    field :token, String, null: true

    def execute(email:, password:)
      user = User.find_by_email!(email)

      raise GraphQL::ExecutionError, "Invalid credentials" unless user&.authenticate(password)

      { token: user.token }
    end
  end
end
