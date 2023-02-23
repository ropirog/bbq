class Subscription < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  with_options unless: -> { user.present? } do
    validates :user_name, presence: true
    validates :user_email, presence: true,
              uniqueness: { scope: :event_id },
              format: { with: URI::MailTo::EMAIL_REGEXP }
    validate :prohibition_to_use_registered_email
  end

  with_options if: -> { user.present? } do
    validates :user, uniqueness: { scope: :event_id }
    validate :prohibition_self_subscribe
  end

  def user_name
    if user.present?
      user.name
    else
      super
    end
  end

  def user_email
    if user.present?
      user.email
    else
      super
    end
  end

  private

  def prohibition_self_subscribe
    errors.add(:user, :self_subscribe) if event.user == user
  end

  def prohibition_to_use_registered_email
    errors.add(:user_email, :registered_email) if User.find_by(email: user_email).present?
  end
end
