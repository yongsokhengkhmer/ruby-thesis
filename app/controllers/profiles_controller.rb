class ProfilesController < ApplicationController
  before_action :load_data, only: [:edit, :update]

  def edit
    if @user.applicant?
      @user.build_user_profile unless @user.user_profile
    else
      @user.build_company_profile unless @user.company_profile
    end
  end

  def update
    if @user.update_attributes user_params
      redirect_to root_path
    else
      render "edit"
    end
  end

  private
  def user_params
    params.require(:user).permit User::USER_PARAMS
  end

  def load_data
    @user = current_user
    @degrees = Degree.all.collect{|degree| [degree.name, degree.id]}
  end
end
