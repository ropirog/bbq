class Photo < ApplicationRecord
  belongs_to :event
  belongs_to :user

  has_one_attached :photo do |attachable|
    attachable.variant :common, resize_to_fit: [800, 800]
    attachable.variant :thumb, resize_to_fit: [100, 100]
  end

  validate :prohibition_to_add_photo
  scope :persisted, -> { where "id IS NOT NULL" }

  private

  def prohibition_to_add_photo
    errors.add(:user, :prohibition_to_add_photo) unless event.visitors.include?(user)
  end
end
