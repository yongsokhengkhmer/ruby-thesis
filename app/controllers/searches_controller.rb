class SearchesController < ApplicationController
  def users
    name = params[:name]
    job_type = (params[:job_types].present? ?  params[:job_types] : current_user.job_types.pluck(:name)).join(" ")
    location = params[:location].present? ? params[:location] : current_user.address

    user_ids = UsersIndex.search_user(name: name, job_type: job_type, address: location)
      .per(Settings.search.user_per_page).map(&:id)
    @users = User.preload(:user_profile).by_ids_order user_ids

    respond_to do |format|
      format.js
      format.html
    end
  end
end
