class ActivitiesController < ApplicationController
  load_resource
  before_action :load_trackable, only: [:edit, :destroy]

  def index
    @user = User.find params[:user_id]
    if @user == current_user
      @activities = @user.activities.load_activities.page params[:page]
    else
      @activities = @user.activities.load_public_activities.page params[:page]
    end

    respond_to do |format|
      format.html {render "profiles/index"}
      format.js {render "static_pages/home.js.erb"}
    end
  end

  def show
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @trackable.destroy

    respond_to do |format|
      format.js
    end
  end

  private
  def load_trackable
    @trackable = @activity.trackable
  end
end
