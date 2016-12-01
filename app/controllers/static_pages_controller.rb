class StaticPagesController < ApplicationController
  def home
    followed_ids = current_user.followeds.pluck(:followed_id) << current_user.id
    @activities = Activity.load_public_activities_of(followed_ids).page params[:page]

    respond_to do |format|
      format.js
      format.html do
        redirect_to admin_root_path if current_user.admin?
        @job_types = JobType.all
        @post = Post.new
        @post.build_job_post
        @post.build_activity

        if current_user.recruiter?
          recruiter_ids = RecruitersIndex.suggest_to_recruiter current_user
          applicant_ids = ApplicantsIndex.suggest_to_recruiter current_user
        elsif current_user.applicant?
          recruiter_ids = RecruitersIndex.suggest_to_applicant current_user
          applicant_ids = ApplicantsIndex.suggest_to_applicant current_user
          suggest_jobs = JobsIndex.suggest_to_applicant(current_user).map &:id
          @suggest_jobs = JobPost.preload(post: [:user, :activity]).by_ids_order suggest_jobs
        else
          recruiter_ids = []
          applicant_ids = []
        end
        @recruiters = User.preload(:user_profile, :country).by_ids_order recruiter_ids.map(&:id)
        @applicants = User.preload(:user_profile, :country).by_ids_order applicant_ids.map(&:id)
      end
    end
  end
end
