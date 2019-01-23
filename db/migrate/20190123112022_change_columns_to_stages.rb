class ChangeColumnsToStages < ActiveRecord::Migration[5.1]
  def change
    add_column :stages, :deadline, :datetime
    add_column :stages, :end_flag, :boolean, default: false
    remove_column :stages, :sold
  end
end
