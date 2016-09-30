class StaticPagesController < ApplicationController
  def home
    @activities = Activity.all
    @job_types = JobType.all
    @post = Post.new
    @post.build_job_post
  end
end
