class Productz < ApplicationRecord
    self.table_name = 'products'
    has_one :product_orders
    belongs_to :restaurant

    validates :name, presence: { message: "can't be blank" }
    validates :restaurant_id, presence: { message: "can't be blank" }
    validates :cost, presence: { message: "can't be blank" } 

    before_validation :empty_string_to_nil

    private
  
    def empty_string_to_nil
      self.restaurant_id = nil if restaurant_id == ""
      self.cost = nil if cost == "" 
    end
  end