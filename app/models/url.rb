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
class Url < ApplicationRecord
  belongs_to :user, optional: true

  validates :original_url, :count, presence: true
  validates :short_code, presence: true, uniqueness: true

  before_validation :generate_short_code, on: :create

  def generate_short_code
    self.short_code ||= SecureRandom.hex(3)
  end
end
