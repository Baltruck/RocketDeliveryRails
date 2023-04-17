class CreateEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :employees do |t|
      t.integer :user_id, null: false
      t.integer :address_id, null: false
      t.string :phone, null: false
      t.string :email

      t.timestamps null: false
    end

    add_index :employees, :user_id, unique: true
  end
end
