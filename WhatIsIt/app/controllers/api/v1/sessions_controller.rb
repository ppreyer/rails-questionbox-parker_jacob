class Api::V1::SessionsController < ApplicationController
    skip_before_action :verify_authentication
    
    def create
      user = User.find_by(username: params[:username])

      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        session[:api_token] = user.api_token
        render json: user, status: 201
      else
          render json: { error: "Invalid credentials" }, status: :unauthorized
      end
    end

    def destroy
      session[:api_token] = nil
      render status: 200
    end
end