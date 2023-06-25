module Types
  class MutationType < Types::BaseObject
    field :create_user, mutation: Mutations::CreateUser
    field :update_user, mutation: Mutations::UpdateUser
    field :delete_user, mutation: Mutations::DeleteUser
    field :login, mutation: Mutations::Login
    field :logout, mutation: Mutations::Logout
    field :create_url, mutation: Mutations::CreateUrl
    field :resolve_short_url, mutation: Mutations::ResolveShortUrl
    field :url_stats, mutation: Mutations::UrlStats
  end
end
