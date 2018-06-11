class SessionsController < ApplicationController
    skip_before_action :verify_authentication
    
    def create
      user = User.find_by(username: params[:username])

      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        session[:api_token] = user.api_token
        redirect_to questions_path
      else
          render json: { error: "Invalid credentials" }, status: :unauthorized
      end
    end

    def destroy
      session[:user_id] = nil
      redirect_to questions_path, notice: "You have successfully logged out!"
    end
end
