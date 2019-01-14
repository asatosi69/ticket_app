class CreateStages < ActiveRecord::Migration[5.1]
  def change
    create_table :stages do |t|
      t.string :performance
      t.integer :total
      t.integer :sold

      t.timestamps
    end
  end
end
