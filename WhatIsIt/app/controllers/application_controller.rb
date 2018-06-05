class ApplicationController < ActionController::Base
    include ActionController::HttpAuthentication::Token::ControllerMethods
    before_action :verify_authentication
  
    def verify_authentication
      user = authenticate_with_http_token do |token, options|
        User.find_by(api_token: token)
      end
  
      unless user
        redirect_to session_path
        flash.now[:alert] = "You are not authorized, please try logging in again."
        render json: { error: "You do not have permission to access these resources" }, status: :unauthorized
      end
    end

    helper_method :current_user

    def current_user    
        if session[:user_id]
            @user ||= User.find(session[:user_id])
            return @user
        end
    end
end
