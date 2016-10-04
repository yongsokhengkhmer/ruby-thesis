class JobPostsController < ApplicationController
  load_and_authorize_resource

  def index
    @job_posts = JobPost.by_user(current_user.id).page params[:page]
  end

  def show
  end
end
