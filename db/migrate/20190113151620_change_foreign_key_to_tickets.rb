class ChangeForeignKeyToTickets < ActiveRecord::Migration[5.1]
  def change
    remove_reference :tickets, :performance
    remove_reference :tickets, :kind
  end
end
