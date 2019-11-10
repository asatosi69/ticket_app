class AddFuriganaToTicket < ActiveRecord::Migration[5.1]
  def change
    add_column :tickets, :furigana, :string
  end
end
