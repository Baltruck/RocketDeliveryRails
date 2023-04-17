module Api
    class AuthController < ApplicationController
      def index
        user = User.find_by(email: params[:email])
        if user && user.valid_password?(params[:password])
          render json: { success: true }
        else
          render json: { success: false }, status: :unauthorized
        end
      end
    end
  end
  