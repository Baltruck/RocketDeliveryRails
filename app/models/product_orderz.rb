class ProductOrderz < ApplicationRecord
    self.table_name = 'product_orders'
    belongs_to :product
    belongs_to :order
  
    validates :product_id, presence: { message: "Product can't be blank" }
    validates :order_id, presence: { message: "Order can't be blank" }
    validates :product_quantity, presence: { message: "Product quantity can't be blank" }

    
  end
