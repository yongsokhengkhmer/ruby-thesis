class Admin::FeedbacksController < ApplicationController
  load_and_authorize_resource

  def index
    @feedbacks = Feedback.order(created_at: :desc).preload(:user).page params[:page]
  end

  def show
  end

  def destroy
    @feedback.destroy
    flash[:success] = t "admin.flashes.feedbacks.destroy.success"
    redirect_to admin_feedbacks_path
  end
end
