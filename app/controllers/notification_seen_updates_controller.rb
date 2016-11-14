class NotificationSeenUpdatesController < ApplicationController
  def update
    current_user.received_notifications.unseen.update_all status: UserNotification.statuses[:seen]
  end

  def update_messages
    Message.load_unread_messages(current_user.id, params[:conversation_id]).update_all read: true
    @unread_conversation = Conversation.unread_conversation current_user.id
    respond_to do |format|
      format.js
    end
  end
end
