class NotificationsController < ApplicationController
  def index
    @notifications = current_user.received_notifications
      .load_notifications.page params[:page]
  end
end
