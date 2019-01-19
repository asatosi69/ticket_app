class AddComment2ToTicket < ActiveRecord::Migration[5.1]
  def change
    add_column :tickets, :comment2, :text
  end
end
