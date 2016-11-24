class Admin::PostsController < ApplicationController
  load_and_authorize_resource

  def index
    @posts = Post.load_posts.page params[:page]
  end

  def destroy
    @post.destroy
    flash[:success] = t "admin.flashes.posts.destroy.success"
    redirect_to admin_posts_path
  end
end
