class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  has_many :events, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_one_attached :avatar do |attachable|
    attachable.variant :common, resize_to_fit: [400, 400]
    attachable.variant :thumb, resize_to_fit: [100, 100]
  end

  before_validation :downcase_email
  validates :name, presence: true, length: { maximum: 35 }

  after_commit :link_subscriptions, on: :create

  private

  def downcase_email
    email&.downcase!
  end

  def link_subscriptions
    Subscription.where(user_id: nil, user_email: email).update_all(user_id: id)
  end
end
