class Admin::RecruitersController < ApplicationController
  load_and_authorize_resource :user, parents: false

  def index
    @recruiters = User.recruiter.preload(:country).order(:name).page params[:page]
  end

  def destroy
    @recruiter = User.find params[:id]
    @recruiter.destroy
    flash[:success] = t "admin.flashes.recruiters.destroy.success"
    redirect_to admin_recruiters_path
  end
end
