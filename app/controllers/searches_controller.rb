class SearchesController < ApplicationController
  def users
    name = params[:name]
    job_type = params[:job_types]
    location = params[:location]

    @user_results = UsersIndex.search_user(name, job_type, location, current_user)
      .per(Settings.search.user_per_page).page params[:page]

    @users = User.preload(:user_profile).by_ids_order @user_results.map(&:id)

    respond_to do |format|
      format.js
      format.html
    end
  end
end
