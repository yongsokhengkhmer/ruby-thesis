class RelationshipJob < ApplicationJob
  queue_as :default

  def perform relationship
    notification = relationship.follower.notifications.find_or_create_by notify_type:
      Settings.notifications.notify_types.follow

    user_notification = notification.user_notifications.create sender_id: relationship.follower_id,
      receiver_id: relationship.followed_id

    NotificationBroadCastService.new(
      "notification_channel_#{relationship.followed_id}", user_notification)
      .broadcast
  end
end
