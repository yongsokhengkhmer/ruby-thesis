class NotificationSeenUpdatesController < ApplicationController
  def update
    current_user.user_notifications.unseen.update_all status: UserNotification.statuses[:seen]
    respond_to do |format|
      format.js
    end
  end
end
