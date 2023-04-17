class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.integer :restaurant_id, null: false
      t.string :name, null: false
      t.string :description
      t.integer :cost, null: false

      t.timestamps null: false
    end
    add_check_constraint :products, "cost >= 0", name: "check_cost_greater_than_zero"
  end
end
