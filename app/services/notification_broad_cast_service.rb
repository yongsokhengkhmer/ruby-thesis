class NotificationBroadCastService
  attr_accessor :channel, :notification

  def initialize channel, notification
    @channel = channel
    @notification = notification
  end

  def broadcast
    ActionCable.server.broadcast channel, content: render_notification
  end

  private
  def render_notification
    ApplicationController.renderer.render(partial: "shared/notification",
      locals: {notification: notification})
  end
end
