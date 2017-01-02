class SearchesController < ApplicationController
  load_and_authorize_resource class: false

  def users
    name = params[:name]
    job_type = params[:job_types]
    country = params[:country]

    @user_results = UsersIndex.search_user(name, job_type, country, current_user)
      .per(Settings.search.user_per_page).page params[:page]

    @users = User.preload(:user_profile, :country).by_ids_order @user_results.map(&:id)

    respond_to do |format|
      format.js
      format.html
    end
  end

  def jobs
    name = params[:name]
    job_types = params[:job_types]
    country = params[:country]
    salary_type_id = params[:salary_type]

    @job_results = JobsIndex.search_jobs(name, job_types, country, salary_type_id,
      current_user).per(Settings.search.user_per_page).page params[:page]
    @job_posts = JobPost.preload(:job_types, :country, post: :activity)
      .by_ids_order @job_results.map(&:id)

    respond_to do |format|
      format.js
      format.html
    end
  end
end
