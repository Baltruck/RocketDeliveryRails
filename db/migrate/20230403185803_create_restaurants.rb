class CreateRestaurants < ActiveRecord::Migration[7.0]
  def change
    create_table :restaurants do |t|
      t.integer :user_id, null: false
      t.integer :address_id, null: false
      t.string :phone, null: false
      t.string :email
      t.string :name, null: false
      t.integer :price_range, null: false, default: 1
      t.boolean :active, null: false, default: true

      t.timestamps null: false
    end

    add_index :restaurants, :address_id, unique: true
    add_check_constraint :restaurants, "price_range >= 1 AND price_range <= 3", name: "check_price_range"
  end
end
