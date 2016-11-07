class Message < ApplicationRecord
  MESSAGE_PARAMS = [:content, :conversation_id]

  belongs_to :conversation
  belongs_to :user

  validates :content, presence: true
  validates :conversation_id, presence: true
  validates :user_id, presence: true

  scope :load_messages, ->{preload :user}

  after_create :push_notification

  private
  def push_notification
   ChatJob.perform_now self
  end
end
