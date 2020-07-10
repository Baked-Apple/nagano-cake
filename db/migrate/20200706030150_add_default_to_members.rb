class AddDefaultToMembers < ActiveRecord::Migration[5.2]
  def change
  	change_column_default :members, :leave_status, false
  end
end
