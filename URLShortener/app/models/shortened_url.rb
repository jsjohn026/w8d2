# == Schema Information
#
# Table name: shortened_urls
#
#  id         :bigint(8)        not null, primary key
#  long_url   :string           not null
#  short_url  :string           not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ShortenedUrl < ApplicationRecord
  validates :long_url, :short_url, :user_id, presence: true

  def self.random_code
    possible_url = SecureRandom::urlsafe_base64
    return possible_url unless ShortenedUrl.exists?(possible_url)
    random_code
  end

  def self.generate_short_url(user, long_url)
    create!(user_id: user.id, long_url: long_url, short_url: random_code)
  end

  belongs_to :submitter, 
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

end
