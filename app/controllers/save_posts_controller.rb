class SavePostsController < ApplicationController
  load_and_authorize_resource

  def create
    @save_post = current_user.save_posts.new save_post_params
    if @save_post.save
      flash.now[:notice] = t "flashes.save_posts.create.success"
    else
      flash.now[:alert] = t "flashes.save_posts.create.fail"
    end

    respond_to do |format|
      format.js
    end
  end

  def destroy
    @save_post.destroy
    flash.now[:notice] = t "flashes.save_posts.destroy.success"

    respond_to do |format|
      format.js
    end
  end

  private
  def save_post_params
    params.require(:save_post).permit SavePost::SAVE_POST_PARAMS
  end
end
