class AddPricerangeToRestaurants < ActiveRecord::Migration[7.0]
  def change
    add_column :restaurants, :pricerange, :string
  end
end
