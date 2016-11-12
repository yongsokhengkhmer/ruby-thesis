class Message < ApplicationRecord
  MESSAGE_PARAMS = [:content, :conversation_id, :receiver_id]

  belongs_to :conversation
  belongs_to :sender, class_name: "User", foreign_key: :sender_id
  belongs_to :receiver, class_name: "User", foreign_key: :receiver_id

  validates :content, presence: true
  validates :conversation_id, presence: true
  validates :sender_id, presence: true
  validates :receiver_id, presence: true

  scope :load_messages, ->{preload :sender}
  scope :load_unread_messages, -> user_id, conversation_id do
    where receiver_id: user_id, conversation_id: conversation_id, read: 0
  end
  scope :unread_conversation_number, -> user_id do
    distinct.where(receiver_id: user_id, read: 0).pluck(:conversation_id).size
  end

  after_create :push_notification
  after_create :update_conversation

  delegate :name, to: :sender, prefix: true, allow_nil: true
  delegate :id, to: :conversation, prefix: true, allow_nil: true

  private
  def push_notification
   ChatJob.perform_now self
  end

  def update_conversation
    conversation.update_attributes updated_at: Time.zone.now
  end
end
