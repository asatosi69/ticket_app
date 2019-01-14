class ForeignKeyToTickets < ActiveRecord::Migration[5.1]
  def change
    add_reference :tickets, :stage
    add_reference :tickets, :type
  end
end
