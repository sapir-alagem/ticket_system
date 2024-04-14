class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: :devise_controller?

  private

  def authenticate_user!
    unless user_signed_in? || request.path =~ /\A\/users\/(sign_in|sign_up)\z/
      redirect_to new_user_session_path
    end
  end
end

# class ApplicationController < ActionController::Base
#   before_action :authenticate_user!

#   private

#   # def authenticate_user!
#   #   unless user_signed_in?
#   #     redirect_to new_user_session_path
#   #   end
#   # end
#   # def authenticate_user!
#   #   unless user_signed_in?
#   #     flash[:alert] = "You need to sign in or sign up before continuing."
#   #     redirect_to new_user_session_path
#   #   end
#   # end
#   def authenticate_user!
#     unless User.find_by(authentication_token: params[:authentication_token])
#       render json: { error: 'Unauthorized' }, status: :unauthorized
#     end
#   end
# end
