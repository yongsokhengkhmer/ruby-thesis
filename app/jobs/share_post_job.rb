class SharePostJob < ApplicationJob
  queue_as :default

  def perform share_post
    notification = share_post.post.notifications.find_or_create_by notify_type:
      Settings.notifications.notify_types.share_post

    user_notification = notification.user_notifications.create sender_id: share_post.user_id,
      receiver_id: share_post.post_user_id

    NotificationBroadCastService.new(
      "notification_channel_#{share_post.post_user_id}", user_notification)
      .broadcast
  end
end
