class CommentJob < ApplicationJob
  queue_as :default

  def perform comment
    activity = comment.activity
    trackable = activity.trackable
    ReactionBroadCastService.new("reaction_channel", comment, activity.id).broadcast

    unless trackable.user_id == comment.user_id
      notifications = trackable.notifications
      receiver_id = trackable.user_id
      notification = notifications.find_or_create_by notify_type: Settings.notifications.notify_types.comment
      user_notification = notification.user_notifications.create sender_id: comment.user_id,
        receiver_id: receiver_id

      NotificationBroadCastService.new("notification_channel_#{receiver_id}",
        user_notification).broadcast
    end
  end
end
