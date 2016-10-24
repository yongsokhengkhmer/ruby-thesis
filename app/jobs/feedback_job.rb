class FeedbackJob < ApplicationJob
  queue_as :default

  def perform feedback
    notification = feedback.create_notification notify_type:
      Settings.notifications.notify_types.feedback

    User.admin.each do |user|
      @user_notification = notification.user_notifications.create sender_id: feedback.user_id,
        receiver_id: user.id
    end

    NotificationBroadCastService.new(
      "admin_notification_channel", @user_notification).broadcast
  end
end
