class Customerz < ApplicationRecord
    self.table_name = 'customers'
    belongs_to :user
    belongs_to :address
    has_many :order

    validates :user_id, uniqueness: true
end
