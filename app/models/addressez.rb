class Addressez < ApplicationRecord
    self.table_name = 'addresses'
    has_one :employee
    has_one :restaurants
    has_one :customers
    has_one :couriers
end
