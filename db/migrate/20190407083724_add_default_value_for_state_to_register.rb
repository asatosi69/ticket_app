class AddDefaultValueForStateToRegister < ActiveRecord::Migration[5.1]
  def change
     change_column :registers, :state, :integer, default: 0
  end
end
