class RenameTypeColumnToTypes < ActiveRecord::Migration[5.1]
  def change
    rename_column :types, :type, :kind
  end
end
