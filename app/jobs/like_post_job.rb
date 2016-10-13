class LikePostJob < ApplicationJob
  queue_as :default

  def perform like_post
    trackable = like_post.activity.trackable
    notifications = trackable.notifications

    notification = notifications.find_or_create_by notify_type: Settings.notifications.notify_types.like

    user_notification = notification.user_notifications.create sender_id: like_post.user_id,
      receiver_id: trackable.user_id

    NotificationBroadCastService.new(
      "notification_channel_#{trackable.user_id}", user_notification)
      .broadcast
  end
end
