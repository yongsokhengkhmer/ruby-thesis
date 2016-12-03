class JobPostsController < ApplicationController
  load_and_authorize_resource

  def index
    @job_posts = JobPost.by_user(current_user.id).page params[:page]
  end

  def show
    if params[:apply].present?
      @job_post = JobPost.find params[:job_post_id]
      @apply_jobs = @job_post.apply_jobs.order_by_user.page params[:page]
      respond_to do |format|
        format.js
        format.html
      end
    else
      suggest_applicants = ApplicantsIndex.suggest_to_job(@job_post)
        .per(Settings.recommendation.per_page).map &:id
      @suggest_applicants = User.preload(:user_profile, :country).by_ids_order suggest_applicants
      @apply_jobs = @job_post.apply_jobs.order_by_user.limit Settings.recommendation.per_page
    end
  end
end
