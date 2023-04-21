module Api
  class OrdersController < ApplicationController
    before_action :set_order, only: [:set_status]
    skip_before_action :verify_authenticity_token

    def create
      restaurant = Restaurant.find_by(id: params[:restaurant_id])
      customer = Customer.find_by(id: params[:customer_id])
      products = params[:products]
    
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
      else
        render json: { error: "Failed to create the order" }, status: :unprocessable_entity
        return
      end
    
      render json: @order, status: :ok
    end
    
    

    def index
      user_type = params[:type]
      id = params[:id]
  
      if params[:type].present? && params[:id].present?
        if ['customer'].include?(params[:type])
          @orders = Order.joins(:customer).where(customers: { user_id: params[:id] }) if params[:type] == 'customer'
          puts @orders.inspect
  
          orders = Order.user_orders(user_type, id)
          render json: orders.map(&method(:format_order_long)), status: :ok
  
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
