class UserNotification < ApplicationRecord
  belongs_to :sender, class_name: User, foreign_key: :sender_id
  belongs_to :receiver, class_name: User, foreign_key: :receiver_id
  belongs_to :notification

  scope :load_notifications, -> do
    order(created_at: :desc).preload [{notification: :trackable}, :sender]
  end

  delegate :created_at, to: :notification, prefix: true, allow_nil: true
  delegate :name, to: :sender, prefix: true, allow_nil: true

  enum status: [:unseen, :seen, :read]

  class << self
    def unseen_notification
      number = unseen.size
      number > 0 ? number : nil
    end
  end
end
