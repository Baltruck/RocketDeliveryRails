class Uzer < ApplicationRecord
    self.table_name = 'users'
    has_one :employee
    has_many :restaurants
    has_one :customer
    has_one :courier
    validates :name, presence: true
     # Include default devise modules. Others available are:
     # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

    devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable
end
