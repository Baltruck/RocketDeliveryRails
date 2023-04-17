class Orderz < ApplicationRecord
    self.table_name = 'orders'
    belongs_to :restaurant
    belongs_to :customer
    belongs_to :order_status
    belongs_to :courier
    has_many :product_orders
end
