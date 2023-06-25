class Mutations::UrlStats < Mutations::BaseMutation
  argument :short_code, String, required: true

  field :url, Types::UrlType, null: true

  def execute(short_code:)
    url = Url.find_by!(short_code: short_code)

    { url: url }
  end
end
