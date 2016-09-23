class ProfilesController < ApplicationController
  before_action :load_user
  before_action :load_data, except: :index

  def index
    @user = current_user
    if @user.applicant?
      @skills = @user.skills
      @experiences = @user.experiences
      @educations = @user.educations
      @documents = @user.documents
    end
  end

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

  def load_user
    @user = current_user
  end

  def load_data
    @degrees = Degree.all.collect{|degree| [degree.name, degree.id]}
  end
end
