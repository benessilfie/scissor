# == Schema Information
#
# Table name: urls
#
#  id           :bigint           not null, primary key
#  count        :integer          default(0)
#  original_url :string
#  short_code   :string
#  short_url    :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint
#
# Indexes
#
#  index_urls_on_short_code  (short_code)
#  index_urls_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class UrlSerializer
  include FastJsonapi::ObjectSerializer
  attributes :count, :short_code
  belongs_to :user

  cache_options enabled: true, cache_length: 12.hours
end
