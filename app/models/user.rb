class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  has_many :events, dependent: :destroy

  before_validation :downcase_email
  validates :name, presence: true, length: { maximum: 35 }

  private

  def downcase_email
    email&.downcase!
  end
end
