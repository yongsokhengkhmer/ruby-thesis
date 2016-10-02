class JobPostsController < ApplicationController
  def index
    @job_posts = JobPost.by_user(current_user.id).page params[:page]
  end

  def show
    @job_post = JobPost.find params[:id]
  end
end
