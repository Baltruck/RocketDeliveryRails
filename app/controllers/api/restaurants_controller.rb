module Api
  class Api::RestaurantsController < ApplicationController
    # GET /api/restaurants
    def index
      rating = params[:rating]
      price_range = params[:price_range]
      if rating.present? && !price_range.present? || !rating.present? && price_range.present?
        render json: { error: "Invalid rating or price range" }, status: :unprocessable_entity
      elsif rating.to_i > 5 || price_range.to_i > 3
        render json: { error: "Invalid rating or price range" }, status: :unprocessable_entity
      else
        @restaurants = Restaurant.rating_and_price(rating, price_range)
        render json: @restaurants, status: :ok
      end
    end
  end
end
