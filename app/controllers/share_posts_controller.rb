class SharePostsController < ApplicationController
  load_and_authorize_resource

  def new
    @post = Post.find params[:share_post][:post_id]

    respond_to do |format|
      format.js
    end
  end

  def create
    @share_post = current_user.share_posts.new share_post_params
    if @share_post.save
      @share_post.create_activity user_id: current_user.id
      flash.now[:success] = t "flashes.share_posts.create.success"
    else
      flash.now[:alert] = t "flashes.share_posts.create.fail"
    end

    respond_to do |format|
      format.js
    end
  end

  def update
    unless @share_post.update_attributes share_post_params
      flash.now[:alert] = t "flashes.share_posts.update.fail"
    end
    @activity = @share_post.activity

    respond_to do |format|
      format.js
    end
  end

  private
  def share_post_params
    params.require(:share_post).permit SharePost::SHARE_POST_PARAMS
  end
end
