class NotificationsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "notification_channel_#{current_user.id}"
    current_user.mark_interests.each do |mark_interest|
      stream_from "mark_interest_notification_channel_#{mark_interest.marked_id}"
    end
    stream_from "admin_notification_channel" if current_user.admin?
  end

  def unsubscribed
  end
end
