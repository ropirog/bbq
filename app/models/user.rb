class User < ApplicationRecord
  has_many :events

  before_validation :downcase_email
  validates :name, presence: true, length: { maximum: 35 }
  validates :email, presence: true, uniqueness: true, length: { maximum: 255 }, format: { with: URI::MailTo::EMAIL_REGEXP }

  private

  def downcase_email
    email&.downcase!
  end
end
