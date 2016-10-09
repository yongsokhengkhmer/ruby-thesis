class PostsController < ApplicationController
  load_and_authorize_resource

  def create
    @post = current_user.posts.new post_params
    if @post.save
      @post.create_activity user_id: current_user.id
    end
    respond_to do |format|
      format.js
    end
  end

  private
  def post_params
    params.require(:post).permit Post::POST_PARAMS
  end
end
