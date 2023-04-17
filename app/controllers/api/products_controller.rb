module Api
  class ProductsController < ApplicationController
    before_action :set_product, only: [:show, :edit, :update, :destroy]
    before_action :set_restaurant, only: [:index]

    # GET /products or /products.json
    def index
      if @restaurant
        @products = @restaurant.products.select(:id, :name, :cost)
        render json: @products, status: :ok
      else
        @products = Product.all.select(:id, :name, :cost)
        render json: @products, status: :ok
      end
    end

    # GET /products/1 or /products/1.json
    def show
      render json: @product, status: :ok
    end

    # GET /products/new
    def new
      @product = Product.new
    end

    # GET /products/1/edit
    def edit
    end

    # POST /products or /products.json
    def create
      @product = Product.new(product_params)

      if @product.save
        render json: @product, status: :created, location: @product
      else
        render json: @product.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /products/1 or /products/1.json
    def update
      if @product.update(product_params)
        render json: @product, status: :ok, location: @product
      else
        render json: @product.errors, status: :unprocessable_entity
      end
    end

    # DELETE /products/1 or /products/1.json
    def destroy
      @product.destroy
      head :no_content
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_product
        @product = Product.find(params[:id])
      end

      def set_restaurant
        @restaurant = Restaurant.find_by(id: params[:restaurant])
        render json: { error: 'Invalid restaurant ID' }, status: :unprocessable_entity unless @restaurant || params[:restaurant].blank?
      end

      # Only allow a list of trusted parameters through.
      def product_params
        params.require(:product).permit(:name, :description, :cost, :restaurant_id)
      end
  end
end
