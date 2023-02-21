class Subscription < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  validates :event, presence: true
  validates :user_name, presence: true, unless: -> { user.present? }
  validates :user_email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, unless: -> { user.present? }

  validates :user, uniqueness: { scope: :event_id }, if: -> { user.present? }
  validates :user_email, uniqueness: { scope: :event_id }, unless: -> { user.present? }

  validate :prohibition_self_subscribe, on: :create
  validate :prohibition_to_use_registered_email, on: :create, unless: -> { user.present? }

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
    errors.add(:user, I18n.t("errors.self_subscribe")) if event.user == user
  end

  def prohibition_to_use_registered_email
    errors.add(:user_email, I18n.t("errors.use_registered_email")) if User.find_by(email: user_email).present?
  end
end
