class NotificationsController < ApplicationController
  load_and_authorize_resource

  def index
    @notifications = current_user.received_notifications
      .load_notifications.page params[:page]
  end
end
