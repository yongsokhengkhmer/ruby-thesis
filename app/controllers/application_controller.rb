class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_out_path_for resource
    root_path
  end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = exception.message
    redirect_to root_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up, keys: [:name, :address,
      :phone_number, :avatar, :cover_profile, :role, :expected_salary,
      job_type_ids: [], user_profile_attributes: [:gender, :birth_date]]
  end
end
