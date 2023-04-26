module Api
  class AuthController < ApplicationController
    skip_before_action :verify_authenticity_token
    def index
      user = User.find_by(email: params[:email])
      if user && user.valid_password?(params[:password])
        customer_id = user.customer.try(:id) || 0
        courier_id = user.courier.try(:id) || 0
        render json: { success: true, user_id: user.id, customer_id: customer_id, courier_id: courier_id }
      else
        render json: { success: false }, status: :unauthorized
      end
    end
  end
end
