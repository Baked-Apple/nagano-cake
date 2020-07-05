class AddColumnsToMembers < ActiveRecord::Migration[5.2]
  def change
    add_column :members, :last_name, :string
    add_column :members, :first_name, :string
    add_column :members, :kana_last_name, :string
    add_column :members, :kana_first_name, :string
    add_column :members, :postal_code, :string
    add_column :members, :address, :string
    add_column :members, :phone_number, :string
    add_column :members, :leave_status, :integer
  end
end
