module Mutations
  class CreateUrl < BaseMutation
    argument :original_url, String, required: true

    field :url, Types::UrlType, null: true

    def execute(original_url:)
      url = Url.create!(original_url: original_url, user: context[:current_user])
      url.update!(short_url: "#{context[:request].base_url}/#{url.short_code}")

      { url: url }
    end
  end
end
