class Conversation < ApplicationRecord
  CONVERSATION_PARAMS = [:receiver_id]

  belongs_to :sender, class_name: "User", foreign_key: :sender_id
  belongs_to :receiver, class_name: "User", foreign_key: :receiver_id

  has_many :messages, dependent: :destroy

  delegate :name, :avatar_url, to: :receiver, prefix: true, allow_nil: true

  validates_uniqueness_of :sender_id, scope: :receiver_id

  scope :existing_conversation, -> sender_id, receiver_id do
    where("(sender_id = ? AND receiver_id = ?) OR (sender_id = ? AND receiver_id = ?)",
    sender_id, receiver_id, receiver_id, sender_id)
  end

  scope :load_conversations_of, -> user_id do
    where("sender_id = ? OR receiver_id = ?", user_id, user_id)
    .preload(:receiver, :sender).order created_at: :desc
  end

  def conversation_partner current_user
    sender_id == current_user.id ? receiver : sender
  end
end
