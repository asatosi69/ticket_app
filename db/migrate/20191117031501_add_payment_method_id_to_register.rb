class AddPaymentMethodIdToRegister < ActiveRecord::Migration[5.1]
  def change
    add_column :registers, :payment_method_id, :integer, null: false, default: 0
  end
end
