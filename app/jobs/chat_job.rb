class ChatJob < ApplicationJob
  queue_as :default

  def perform message
    partner_id = message.conversation.conversation_partner(message.user).id
    ActionCable.server.broadcast "chat_channel_#{partner_id}",
      content: render_content(message)
  end

  private
  def render_content message
    ApplicationController.renderer.render(partial: "messages/message",
      locals: {message: message, user_side: "you"})
  end
end
