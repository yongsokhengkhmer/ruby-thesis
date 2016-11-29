class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_out_path_for resource
    root_path
  end

  def after_sign_in_path_for resource
    current_user.admin? ? admin_root_path : root_path
  end

  rescue_from CanCan::AccessDenied do |exception|
    flash.now[:alert] = exception.message
    redirect_to current_user.admin? ? admin_root_path : root_path
  end

  def current_ability
    controller_name_segments = params[:controller].split('/')
    controller_name_segments.pop
    controller_namespace = controller_name_segments.join('/').camelize
    Ability.new(current_user, controller_namespace)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up, keys: [:name, :country_id, :address,
      :phone_number, :avatar, :cover_profile, :role, :expected_salary,
      job_type_ids: [], user_profile_attributes: [:gender, :birth_date]]
  end
end
