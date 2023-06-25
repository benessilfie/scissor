module Mutations
  class ResolveShortUrl < BaseMutation
    argument :short_code, String, required: true

    field :url, Types::UrlType, null: true

    def execute(short_code:)
      url = Url.find_by!(short_code: short_code)

      url.increment!(:count)
      { url: url }
    end
  end
end
