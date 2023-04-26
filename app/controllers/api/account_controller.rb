class Api::AccountController < ApplicationController
    skip_before_action :verify_authenticity_token
  
    def index
      user = User.find_by(id: params[:id])
  
      if params[:type] == 'customer'
        customer = Customer.find_by(user_id: user.id)
        render json: { phone: customer.phone, email: customer.email, user_email: user.email }
      elsif params[:type] == 'courier'
        courier = Courier.find_by(user_id: user.id)
        render json: { phone: courier.phone, email: courier.email, user_email: user.email }
      else
        render json: { error: 'Invalid user type' }, status: :bad_request
      end
    end

    def updated
        user = User.find_by(id: params[:id])
        
        if params[:type] == 'customer'
          customer = Customer.find_by(user_id: user.id)
          customer.update(phone: params[:phone], email: params[:email])
          render json: { message: 'Account updated', phone: customer.phone, email: customer.email, user_email: user.email }
        elsif params[:type] == 'courier'
          courier = Courier.find_by(user_id: user.id)
          courier.update(phone: params[:phone], email: params[:email])
          render json: { message: 'Account updated', phone: courier.phone, email: courier.email, user_email: user.email }
        else
          render json: { error: 'Invalid user type' }, status: :bad_request
        end
    end

end