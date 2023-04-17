class Staff < ApplicationRecord
    self.table_name = 'employees'
    belongs_to :user
    belongs_to :address

    validates :user_id, uniqueness: true

end
