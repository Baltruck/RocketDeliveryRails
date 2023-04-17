class Reztaurant < ApplicationRecord
    self.table_name = 'restaurants'
    has_many :products
    has_many :users
    has_many :orders

    validates :user_id, :address_id, :phone, :email, :name, :price_range, :active, presence: true
    validates :address_id, uniqueness: true
    validates :price_range, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 3 }
end
