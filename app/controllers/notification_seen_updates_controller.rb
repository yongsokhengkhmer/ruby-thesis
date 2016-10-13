class NotificationSeenUpdatesController < ApplicationController
  def update
    current_user.received_notifications.unseen.update_all status: UserNotification.statuses[:seen]
  end
end
