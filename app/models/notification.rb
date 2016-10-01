class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :trackable, polymorphic: true

  has_many :user_notifications, dependent: :destroy

  delegate :avatar_url, :name, to: :user, prefix: true, allow_nil: true
end
