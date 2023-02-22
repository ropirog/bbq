class Photo < ApplicationRecord
  belongs_to :event
  belongs_to :user

  has_one_attached :photo do |attachable|
    attachable.variant :common, resize_to_fit: [800, 800]
    attachable.variant :thumb, resize_to_fit: [100, 100]
  end

  validates :event, presence: true
  validates :user, presence: true
  validate :prohibition_to_add_photo, on: :create

  scope :persisted, -> { where "id IS NOT NULL" }

  private

  def prohibition_to_add_photo
    errors.add(:user, I18n.t("errors.prohibition_to_add_photo")) unless event.subscribers.include?(user)
  end
end
