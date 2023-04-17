class CreateProductOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :product_orders do |t|
      t.integer :product_id, null: false
      t.integer :order_id, null: false
      t.integer :product_quantity, null: false 
      t.integer :product_unit_cost, null: false 

      t.timestamps null: false

      t.index ["order_id", "product_id"], unique: true
    end
    add_check_constraint :product_orders, "product_quantity >= 0", name: "check_product_quantity_non_negative"
    add_check_constraint :product_orders, "product_unit_cost >= 0", name: "check_product_unit_cost_non_negative"
  end
end
