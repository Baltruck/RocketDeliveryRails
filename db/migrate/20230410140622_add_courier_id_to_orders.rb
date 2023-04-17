class AddCourierIdToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :courier_id, :integer
    add_foreign_key :orders, :couriers
  end
end
