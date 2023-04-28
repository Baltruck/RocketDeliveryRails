module Api
  class OrdersController < ApplicationController
    before_action :set_order, only: [:set_status]
    skip_before_action :verify_authenticity_token

    require 'rubygems'
    require 'twilio-ruby'
    require 'dotenv/load'
    require 'httparty'

    def send_email_notification(email, subject, body, order_id, user_name, restaurant_name, total_cost)
      api_key = ENV['NOTIFY_API_KEY']
      client_id = ENV['NOTIFY_X_ClientId']
      secret_key = ENV['NOTIFY_X_Secretkey']
    
      url = "https://api.notify.eu/notification/send"
    
      headers = {
        'Authorization' => "Bearer #{api_key}",
        'Content-Type' => 'application/json',
        'X-ClientId' => client_id,
        'X-SecretKey' => secret_key
      }
    
      payload = {
        message: {
          notificationType: "email",
          language: "en",
          params: {
            order_id: order_id,
            user_name: user_name,
            restaurant_name: restaurant_name,
          },
          transport: [
            {
              type: "patate",
              recipients: {
                to: [
                  {
                    name: user_name,
                    recipient: email
                  }
                ]
              }
            }
          ]
        }
      }
    
      response = HTTParty.post(url, headers: headers, body: payload.to_json)

    end
    
    
    

    def create
      restaurant = Restaurant.find_by(id: params[:restaurant_id])
      customer = Customer.find_by(id: params[:customer_id])
      products = params[:products]
      user = User.find_by(id: params[:customer_id])
      user_name = user.name
      confirmation_message = params[:confirmation_message]
      order_id = params[:id]
      restaurant_name = restaurant.name
      total_cost = params[:totalCost]
    
      if params[:restaurant_id].nil? || params[:customer_id].nil? || products.nil? || products.empty?
        render json: { error: "Restaurant ID, customer ID, and products are required" }, status: :bad_request
        return
      end
    
      if restaurant.nil? || customer.nil?
        render json: { error: "Invalid restaurant or customer ID" }, status: :unprocessable_entity
        return
      end
    
      # Create the new order
      @order = Order.new(restaurant: restaurant, customer: customer, order_status: OrderStatus.find_by(name: 'pending'))
    
      if @order.save
        # Create the associated product_orders
        products.each do |product|
          product_order = ProductOrder.new(order: @order, product_id: product[:id], product_quantity: product[:quantity], product_unit_cost: product[:cost])
          unless product_order.save
            @order.destroy
            render json: { error: "Invalid product ID" }, status: :unprocessable_entity
            return
          end
        end
        order_id = @order.id
      else
        render json: { error: "Failed to create the order" }, status: :unprocessable_entity
        return
      end
    
 # CONFIRMATION MESSAGE
 if confirmation_message == 'phone' || confirmation_message == 'both'
  account_sid = ENV['TWILIO_ACCOUNT_SID']
  auth_token = ENV['TWILIO_AUTH_TOKEN']
  @client = Twilio::REST::Client.new account_sid, auth_token
  message = @client.messages.create(
    body: "Order Received! Thank You! Order ##{order_id} for #{user_name}",
    from: '+16812216638',
     to: '+14182786747'
      # replace the line above with the line below to send the message to the customer
      #to: customer.phone_number
     
  )
elsif confirmation_message == 'email' || confirmation_message == 'both'
  total_cost = sprintf('%.2f', @order.total_cost / 100.0).gsub('.', ',')
  email_subject = "Confirmation de commande"
  email_body = "Commande reçue ! Merci ! Commande n°#{order_id} pour #{user_name}"
  send_email_notification('optimix@live.ca', email_subject, email_body, order_id, user_name, restaurant_name, total_cost)
  # replace the line above with the line below to send the email to the customer
  #send_email_notification('customer_email', email_subject, email_body, order_id, user_name, restaurant_name, total_cost)
    
end

      render json: @order, status: :ok
    end

    def set_status
      @order = Order.find_by(id: params[:id])
    
      puts "Current order status: #{@order.order_status.name}" 
    
      case @order.order_status.name
      when "pending"
        new_status_name = "in progress"
      when "in progress"
        new_status_name = "delivered"
      when "delivered"
        render json: { error: "Order has already been delivered" }, status: :unprocessable_entity and return 
      else
        render json: { error: "Invalid order status" }, status: :unprocessable_entity and return
      end
    
      new_status = OrderStatus.find_by(name: new_status_name)
    
      puts "New status name: #{new_status_name}" 
      puts "New status object: #{new_status.inspect}" 
    
      # Check if the new status was found
      if new_status.nil?
        render json: { error: "New order status not found" }, status: :unprocessable_entity and return
      end
    
      if @order.update(order_status: new_status)
        render json: @order, response: :success
      else
        # Show the errors
        puts @order.errors.full_messages
        render json: { error: "Failed to update the order status" }, status: :unprocessable_entity
      end
    end

    def index
      user_type = params[:type]
      id = params[:id]
    
      if params[:type].present? && params[:id].present?
        if ['customer', 'courier'].include?(params[:type])
          if user_type == 'customer'
            @orders = Order.joins(:customer).where(customers: { user_id: params[:id] })
          elsif user_type == 'courier'
            @orders = Order.joins(:courier).where(couriers: { user_id: params[:id] })
          end
    
          render json: @orders.map(&method(:format_order_long)), status: :ok
        else
          render json: { error: "Invalid user type" }, status: :unprocessable_entity
        end
      else
        render json: { error: "Both 'user type' and 'id' parameters are required" }, status: :bad_request
      end
    end
  
    def format_order_long(order)
      {
        id: order.id,
        customer_id: order.customer.id,
        customer_name: order.customer.user.name,
        customer_address: order.customer.address.full_address,
        restaurant_id: order.restaurant.id,
        restaurant_name: order.restaurant.name,
        restaurant_address: order.restaurant.address.full_address,
        courier_id: order.courier&.id,
        courier_name: order.courier&.user&.name,
        status: order.order_status.name,
        products: order.product_orders.map do |po|
          {
            product_id: po.product.id,
            product_name: po.product.name,
            quantity: po.product_quantity,
            unit_cost: po.product_unit_cost,
            total_cost: po.product_quantity * po.product_unit_cost
          }
        end,
        total_cost: order.total_cost
      }
    end

    private

    def set_order
      @order = Order.find_by(id: params[:id])
      if @order.nil?
        render json: { error: "Order not found" }, status: :unprocessable_entity
        return
      end
    end
  end
end
