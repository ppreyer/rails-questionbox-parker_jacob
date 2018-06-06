class Api::V1::SessionsController < ApplicationController
    skip_before_action :verify_authentication
    
    def create
      user = User.find_by(username: params[:username])

      if user && user.authenticate(params[:password])
          session[:api_token] = user.api_token
          redirect_to api_v1_questions_path
      else
          render json: { error: "Invalid credentials" }, status: :unauthorized
      end
    end
end