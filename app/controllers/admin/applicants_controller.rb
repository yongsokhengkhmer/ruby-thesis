class Admin::ApplicantsController < ApplicationController
  load_and_authorize_resource :user, parents: false

  def index
    @applicants = User.applicant.preload(:country).order(:name).page params[:page]
  end

  def destroy
    @applicant = User.find params[:id]
    @applicant.destroy
    flash[:success] = t "admin.flashes.applicants.destroy.success"
    redirect_to admin_applicants_path
  end
end
