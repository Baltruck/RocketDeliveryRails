class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.integer :restaurant_id, null: false
      t.integer :costumer_id, null: false
      t.integer :order_status_id, null: false
      t.integer :restaurant_rating

      t.timestamps null: false
    end
    add_check_constraint :orders, "restaurant_rating >= 1 AND restaurant_rating <= 5", name: "check_restaurant_rating_range"
  end
end
