class UserNotification < ApplicationRecord
  belongs_to :notification
  belongs_to :user

  scope :load_notifications, ->number{limit(number).preload notification: :user}

  delegate :created_at, to: :notification, prefix: true, allow_nil: true

  enum status: [:unseen, :seen, :read]
end
