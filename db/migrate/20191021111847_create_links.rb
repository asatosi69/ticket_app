class CreateLinks < ActiveRecord::Migration[5.1]
  def change
    create_table :links do |t|
      t.integer :type_id, null: false
      t.integer :stage_id, null: false

      t.timestamps
    end
    add_index :links, [:type_id]
    add_index :links, [:stage_id]
  end
end
