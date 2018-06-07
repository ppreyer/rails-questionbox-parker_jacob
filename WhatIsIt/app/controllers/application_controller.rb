class ApplicationController < ActionController::Base
    include ActionController::HttpAuthentication::Token::ControllerMethods
    before_action :verify_authentication
    helper_method :current_user
    protect_from_forgery with: :null_session
  
    def verify_authentication
      user = authenticate_with_http_token do |token, options|
      User.find_by(api_token: token)
    end
  
      unless user
        redirect_to api_v1_session_path, alert: "You are not authorized, please try logging in again."
        render json: { error: "You do not have permission to access these resources" }, status: :unauthorized
      end
    end

    def bearer_token
      pattern = /^Bearer /
      header  = request.headers['Authorization']
      header.gsub(pattern, '') if header && header.match(pattern)
    end

    def current_user    
        @user ||= User.find(api_token: bearer_token)
        return @user
    end
end
