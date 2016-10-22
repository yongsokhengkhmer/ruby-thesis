class PostNotificationJob < ApplicationJob
  queue_as :default

  def perform post
    user = post.user
    if(mark_interests = user.marked_interests).any?
      notification = post.notifications.find_or_create_by notify_type:
        Settings.notifications.notify_types.post_feed

      mark_interests.each do |mark_interest|
        @marker_notification = notification.user_notifications.create sender_id: user.id,
          receiver_id: mark_interest.marker_id
      end

      NotificationBroadCastService.new(
        "mark_interest_notification_channel_#{user.id}", @marker_notification)
          .broadcast
    end
  end
end
