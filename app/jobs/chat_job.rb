class ChatJob < ApplicationJob
  queue_as :default

  def perform message
    ActionCable.server.broadcast "chat_channel_#{message.receiver_id}",
      content: render_content(message),
      conversation_content: render_conversation_content(message),
      conversation_id: message.conversation_id,
      unread_conversation: Conversation.unread_conversation(message.receiver_id)
  end

  private
  def render_content message
    ApplicationController.renderer.render(partial: "messages/message",
      locals: {message: message, user_side: "you"})
  end

  def render_conversation_content message
    ApplicationController.renderer.render(partial: "conversations/conversation",
      locals: {conversation: message.conversation, active_conversation: nil,
      conversation_name: message.sender_name, current_user: message.receiver})
  end
end
