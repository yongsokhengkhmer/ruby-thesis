class PostsController < ApplicationController
  load_and_authorize_resource

  def index
    @posts = current_user.posts.load_posts.page params[:page]
  end

  def create
    @post = current_user.posts.new post_params
    @post.save

    respond_to do |format|
      format.js
    end
  end

  def update
    @post.update_attributes post_params
    @activity = @post.activity

    respond_to do |format|
      format.js
    end
  end

  private
  def post_params
    params.require(:post).permit Post::POST_PARAMS
  end
end
