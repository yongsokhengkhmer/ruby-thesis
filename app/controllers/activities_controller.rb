class ActivitiesController < ApplicationController
  load_and_authorize_resource
  before_action :load_trackable, only: [:edit, :destroy]

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
