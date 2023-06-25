class Queries::Profile < Queries::BaseQuery
  description "Fetches the current user's profile"
  type Types::UserType, null: true

  def resolve()
    context[:current_user]
  end
end
