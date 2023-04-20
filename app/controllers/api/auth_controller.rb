module Api
    class AuthController < ApplicationController
      skip_before_action :verify_authenticity_token
      def index
        user = User.find_by(email: params[:email])
        if user && user.valid_password?(params[:password])
          render json: { success: true, user_id: user.id, customer_id: user.customer.id, courier_id: user.courier.id }
        else
          render json: { success: false }, status: :unauthorized
        end
      end
    end
  end
  