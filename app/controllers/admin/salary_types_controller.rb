class Admin::SalaryTypesController < ApplicationController
  load_and_authorize_resource
  before_action :load_data, only: [:index, :create]

  def index
  end

  def new
  end

  def create
    if @salary_type.save
      flash.now[:success] = t "admin.flashes.salary_types.create.success"
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
    if @salary_type.update_attributes salary_type_params
      flash.now[:success] = t "admin.flashes.salary_types.update.success"
    end
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @salary_type.destroy
    flash[:success] = t "admin.flashes.salary_types.destroy.success"
    redirect_to admin_salary_types_path
  end

  private
  def salary_type_params
    params.require(:salary_type).permit SalaryType::SALARY_TYPE_PARAMS
  end

  def load_data
    @salary_types = SalaryType.page params[:page]
  end
end
