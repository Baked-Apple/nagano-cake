class AddNullToMembers < ActiveRecord::Migration[5.2]
  def change
  	change_column_null :members, :leave_status, false, 0
  end
end
