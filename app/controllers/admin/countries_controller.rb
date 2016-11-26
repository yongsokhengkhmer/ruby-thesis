class Admin::CountriesController < ApplicationController
  load_and_authorize_resource
  before_action :load_data, only: [:index, :create]

  def index
  end

  def new
  end

  def create
    if @country.save
      flash.now[:success] = t "admin.flashes.countries.create.success"
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
    if @country.update_attributes country_params
      flash.now[:success] = t "admin.flashes.countries.update.success"
    end
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @country.destroy
    flash[:success] = t "admin.flashes.countries.destroy.success"
    redirect_to admin_countries_path
  end

  private
  def country_params
    params.require(:country).permit Country::COUNTRY_PARAMS
  end

  def load_data
    @countries = Country.order(:name).page params[:page]
  end
end
