class SharePostJob < ApplicationJob
  queue_as :default

  def perform share_post
    user = share_post.user
    post_user_id = share_post.post_user_id

    notification = share_post.post.notifications.find_or_create_by notify_type:
      Settings.notifications.notify_types.share_post

    post_owner_notification = notification.user_notifications.create sender_id: user.id,
      receiver_id: post_user_id

    NotificationBroadCastService.new(
      "notification_channel_#{share_post.post_user_id}", post_owner_notification)
      .broadcast

    if(mark_interests = user.marked_interests).any?
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
