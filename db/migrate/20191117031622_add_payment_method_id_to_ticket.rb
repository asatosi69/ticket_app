class AddPaymentMethodIdToTicket < ActiveRecord::Migration[5.1]
  def change
    add_column :tickets, :payment_method_id, :integer, null: false, default: 0
  end
end
