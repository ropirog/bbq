class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  has_many :events, dependent: :destroy

  before_validation :downcase_email
  before_validation :set_name, on: :create
  validates :name, presence: true, length: { maximum: 35 }

  private

  def downcase_email
    email&.downcase!
  end

  def set_name
    self.name = "User №#{rand(777)}" if self.name.blank?
  end
end
