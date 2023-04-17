class FixColumnNameInOrders < ActiveRecord::Migration[7.0]
  def change
    rename_column :orders, :costumer_id, :customer_id
  end
end
