class JobPostsController < ApplicationController
  load_and_authorize_resource

  def index
    @job_posts = JobPost.by_user(current_user.id).page params[:page]
  end

  def show
    suggest_applicants = ApplicantsIndex.suggest_to_job(@job_post).map &:id
    @suggest_applicants = User.preload(:user_profile).by_ids_order suggest_applicants
  end
end
