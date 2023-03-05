class Event < ApplicationRecord
  belongs_to :user

  with_options dependent: :destroy do
    has_many :comments
    has_many :photos
    has_many :subscriptions
  end

  has_many :subscribers, through: :subscriptions, source: :user

  with_options presence: true do
    validates :user
    validates :title, length: { maximum: 255 }
    validates :address
    validates :datetime
  end

  def visitors
    subscribers + [user]
  end

  def pincode_valid?(pin2check)
    pincode == pin2check
  end
end
