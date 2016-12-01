class RecommendationsController < ApplicationController

  def recruiters
    if current_user.recruiter?
      @result_ids = RecruitersIndex.suggest_to_recruiter(current_user)
        .per(Settings.search.user_per_page).page params[:page]
    elsif current_user.applicant?
      @result_ids = RecruitersIndex.suggest_to_applicant current_user
        .per(Settings.search.user_per_page).page params[:page]
    end
    @recruiters = User.preload(:user_profile, :country).by_ids_order @result_ids.map(&:id)

    respond_to do |format|
      format.js
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
    @applicants = User.preload(:user_profile, :country).by_ids_order @result_ids.map(&:id)

    respond_to do |format|
      format.js
      format.html
    end
  end
end
