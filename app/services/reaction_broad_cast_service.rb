class ReactionBroadCastService
  attr_accessor :channel, :comment, :activity_id

  def initialize channel, comment, activity_id
    @channel = channel
    @comment = comment
    @activity_id = activity_id
  end

  def broadcast
    ActionCable.server.broadcast channel, content: render_content, activity_id: activity_id
  end

  private
  def render_content
    ApplicationController.renderer.render(partial: "comments/comment",
      locals: {comment: comment})
  end
end
