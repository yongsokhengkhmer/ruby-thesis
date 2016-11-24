class Admin::JobPostsController < ApplicationController
  load_and_authorize_resource

  def index
    @job_posts = JobPost.load_job_posts.page params[:page]
  end
end
