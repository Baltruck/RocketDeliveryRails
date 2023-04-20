module Api
  class Api::RestaurantsController < ApplicationController
    def index
      rating = params[:rating].to_i
      price_range = params[:price_range].to_i
      if rating > 5 || price_range > 3
        render json: { error: "Invalid rating or price range" }, status: :unprocessable_entity
      elsif rating.zero? && price_range.zero?
        @restaurants = Restaurant.all
        restaurant_ratings = @restaurants.joins(:orders).group(:restaurant_id).average(:restaurant_rating)
        render json: @restaurants.select(:id, :name, :price_range).map { |restaurant|
        {
          id: restaurant.id,
          name: restaurant.name,
          price_range: restaurant.price_range,
          restaurant_rating: restaurant_ratings[restaurant.id].to_f.round(1)
        }
      }, status: :ok
      else
        @restaurants = Restaurant.rating_and_price(rating, price_range)
        restaurant_ratings = @restaurants.joins(:orders).group(:restaurant_id).average(:restaurant_rating)
        render json: @restaurants.select(:id, :name, :price_range).map { |restaurant|
        {
          id: restaurant.id,
          name: restaurant.name,
          price_range: restaurant.price_range,
          restaurant_rating: restaurant_ratings[restaurant.id].to_f.round(1)
        }
      }, status: :ok
      end
    end
  end
end
