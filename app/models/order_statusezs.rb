class OrderStatusezs < ApplicationRecord
    self.table_name = 'order_statuses'
    has_many :orders

    validates :name, presence: true
  end
  
