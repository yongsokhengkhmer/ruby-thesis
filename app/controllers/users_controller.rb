class UsersController < ApplicationController
  load_and_authorize_resource

  def show
    if @user.applicant?
      @skills = @user.skills
      @experiences = @user.experiences.order_date
      @educations = @user.educations.order_date
      @documents = @user.documents
    end
    render "profiles/index"
  end
end
