class AddNicknameToPaymentMethod < ActiveRecord::Migration[5.1]
  def change
    add_column :payment_methods, :nickname, :string, null: false, default: ''
  end
end
