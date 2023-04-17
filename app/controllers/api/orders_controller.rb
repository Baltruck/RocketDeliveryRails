module Api
  class OrdersController < ApplicationController
    before_action :set_order, only: [:set_status]

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
      if params[:type].present? && params[:id].present?
        if ['customer'].include?(params[:type]) 
          @orders = Order.joins(:customer).where(customers: { user_id: params[:id] }) if params[:type] == 'customer'
          render json: @orders
        else
          render json: { error: "Invalid user type" }, status: :unprocessable_entity
        end
      else
        render json: { error: "Both 'user type' and 'id' parameters are required" }, status: :bad_request
      end
    end
    
    def set_status
      new_status = params[:status]

      unless ["pending", "in progress", "delivered"].include?(new_status)
        render json: { error: "Invalid status" }, status: :unprocessable_entity
        return
      end

      if @order.update(order_status: OrderStatus.find_or_create_by(name: new_status))
        render json: { message: "Order status updated successfully" }, status: :ok
      else
        render json: { error: "Failed to update order status" }, status: :unprocessable_entity
      end
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
