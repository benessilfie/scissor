# frozen_string_literal: true

module Types
  class UrlType < Types::BaseObject
    field :id, ID, null: false
    field :original_url, String
    field :short_code, String
    field :short_url, String
    field :count, Integer
    field :user_id, Integer, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
