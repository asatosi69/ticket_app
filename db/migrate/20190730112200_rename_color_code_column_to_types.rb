class RenameColorCodeColumnToTypes < ActiveRecord::Migration[5.1]
  def change
    rename_column :types, :color_code, :color_id
    change_column :types, :color_id, :integer
  end
end
