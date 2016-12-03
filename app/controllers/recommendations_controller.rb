class RecommendationsController < ApplicationController

  def recruiters
    if current_user.recruiter?
      @result_ids = RecruitersIndex.suggest_to_recruiter(current_user)
        .per(Settings.search.user_per_page).page params[:page]
    elsif current_user.applicant?
      @result_ids = RecruitersIndex.suggest_to_applicant(current_user)
        .per(Settings.search.user_per_page).page params[:page]
    end
    @users = User.preload(:user_profile, :country).by_ids_order @result_ids.map(&:id)

    respond_to do |format|
      format.js {render "load_more_users.js.erb"}
      format.html
    end
  end

  def applicants
    if current_user.recruiter?
      @result_ids = ApplicantsIndex.suggest_to_recruiter(current_user)
        .per(Settings.search.user_per_page).page params[:page]
    elsif current_user.applicant?
      @result_ids = ApplicantsIndex.suggest_to_applicant(current_user)
        .per(Settings.search.user_per_page).page params[:page]
    end
    @users = User.preload(:user_profile, :country).by_ids_order @result_ids.map(&:id)

    respond_to do |format|
      format.js {render "load_more_users.js.erb"}
      format.html
    end
  end

  def applicants_to_job
    @job_post = JobPost.find params[:job_post_id]
    @result_ids = ApplicantsIndex.suggest_to_job(@job_post)
      .per(Settings.search.user_per_page).page params[:page]
    @users = User.preload(:user_profile, :country).by_ids_order @result_ids.map(&:id)

    respond_to do |format|
      format.js {render "load_more_users.js.erb"}
      format.html
    end
  end

  def jobs_to_applicant
    @result_ids = JobsIndex.suggest_to_applicant(current_user)
      .per(Settings.search.user_per_page).page params[:page]
    @suggest_jobs = JobPost.preload(post: [:user, :activity]).by_ids_order @result_ids.map(&:id)

    respond_to do |format|
      format.js
      format.html
    end
  end
end
