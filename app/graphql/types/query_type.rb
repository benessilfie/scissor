module Types
  class QueryType < Types::BaseObject
    field :profile, resolver: Queries::Profile
  end
end
