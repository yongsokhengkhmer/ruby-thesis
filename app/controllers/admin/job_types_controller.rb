class Admin::JobTypesController < ApplicationController
  load_and_authorize_resource
  before_action :load_data, only: [:index, :create]

  def index
  end

  def new
  end

  def create
    if @job_type.save
      flash.now[:success] = t "admin.flashes.job_types.create.success"
    end
    respond_to do |format|
      format.js
    end
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    if @job_type.update_attributes job_type_params
      flash.now[:success] = t "admin.flashes.job_types.update.success"
    end
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @job_type.destroy
    flash[:success] = t "admin.flashes.job_types.destroy.success"
    redirect_to admin_job_types_path
  end

  private
  def job_type_params
    params.require(:job_type).permit JobType::JOB_TYPE_PARAMS
  end

  def load_data
    @job_types = JobType.order(:name).page params[:page]
  end
end
