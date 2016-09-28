class RegistrationsController < Devise::RegistrationsController
  def create
    render :edit if params[:user][:role] == Settings.roles.admin
    super
  end
end
