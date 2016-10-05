class LikePostsController < ApplicationController
  load_and_authorize_resource

  def create
    @like_post = current_user.like_posts.new like_post_params
    flash.now[:alert] = t("flashes.new_feeds.like.error") unless @like_post.save
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @activity = @like_post.activity
    @like_post.destroy
    respond_to do |format|
      format.js
    end
  end

  private
  def like_post_params
    params.require(:like_post).permit LikePost::LIKE_POST_PARAMS
  end
end
