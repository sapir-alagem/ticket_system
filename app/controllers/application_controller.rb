class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: :devise_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  private

  def authenticate_user!
    unless user_signed_in? || request.path =~ /\A\/users\/(sign_in|sign_up)\z/
      redirect_to new_user_session_path
    end
  end
end
