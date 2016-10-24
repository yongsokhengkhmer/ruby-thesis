class CommentsController < ApplicationController
  load_and_authorize_resource

  def index
    @activity = Activity.find params[:comment][:activity_id]
    @comments = @activity.comments.preload(:user).order(id: :desc)
      .page(params[:page]).per(Settings.comments.limit)
      .padding params[:new_comment_count].to_i
    respond_to do |format|
      format.js
    end
  end

  def create
    @comment = current_user.comments.new comment_params
    flash.now[:alert] = t("flashes.new_feeds.like.error") unless @comment.save
    respond_to do |format|
      format.js
    end
  end

  def comment_params
    params.require(:comment).permit Comment::COMMENT_PARAMS
  end
end
