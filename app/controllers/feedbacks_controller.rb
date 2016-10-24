class FeedbacksController < ApplicationController
  load_and_authorize_resource

  def index
    @feedbacks = Feedback.order(created_at: :desc).preload(:user).page params[:page]
  end

  def show
  end

  def new
  end

  def create
    @feedback = current_user.feedbacks.new feedback_params
    if @feedback.save
      flash[:success] = t "flashes.feedbacks.create.success"
      redirect_to root_path
    else
      render :new
    end
  end

  private
  def feedback_params
    params.require(:feedback).permit Feedback::FEEDBACK_PARAMS
  end
end
