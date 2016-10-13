class NotificationBroadCastService
  attr_accessor :channel, :user_notification

  def initialize channel, user_notification
    @channel = channel
    @user_notification = user_notification
  end

  def broadcast
    ActionCable.server.broadcast channel, content: render_notification
  end

  private
  def render_notification
    ApplicationController.renderer.render(partial: "shared/user_notification",
      locals: {user_notification: user_notification})
  end
end
