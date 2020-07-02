class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :member_id
      t.integer :total_fee
      t.integer :postage
      t.integer :pay_type
      t.string :delivery_name
      t.string :postal_code
      t.string :address
      t.integer :order_status

      t.timestamps
    end
  end
end
