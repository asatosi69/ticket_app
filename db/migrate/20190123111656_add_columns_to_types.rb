class AddColumnsToTypes < ActiveRecord::Migration[5.1]
  def change
    add_column :types, :price, :integer
  end
end
