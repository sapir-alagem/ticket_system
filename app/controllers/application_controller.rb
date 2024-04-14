class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: :devise_controller?

  private

  def authenticate_user!
    unless user_signed_in? || request.path =~ /\A\/users\/(sign_in|sign_up)\z/
      redirect_to new_user_session_path
    end
  end
end
