class ProfilesController < ApplicationController
  before_action :load_user
  before_action :load_data, except: :index

  def index
    if @user.applicant?
      @skills = @user.skills
      @experiences = @user.experiences.order_date
      @educations = @user.educations.order_date
      @documents = @user.documents
    end
  end

  def edit
    if @user.recruiter?
      @user.build_company_profile unless @user.company_profile
    else
      @user.build_user_profile unless @user.user_profile
    end
  end

  def update
    if @user.update_attributes user_params
      redirect_to profiles_path
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
    @genders = UserProfile.genders.keys.map{|gender| [gender.capitalize, gender]}
  end
end
