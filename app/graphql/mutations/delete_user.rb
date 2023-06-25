module Mutations
  class DeleteUser < BaseMutation
    argument :password, String, required: true

    field :success, Boolean, null: true

    def execute(password:)
      user = context[:current_user]
      raise NotAuthorized, "Invalid credentials" unless user&.authenticate(password)

      user.destroy!
      { success: true }
    end
  end
end
