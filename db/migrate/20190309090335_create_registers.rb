class CreateRegisters < ActiveRecord::Migration[5.1]
  def change
    create_table :registers do |t|
      t.integer :user_id
      t.integer :count
      t.string :b_name
      t.string :b_email
      t.integer :stage_id
      t.integer :type_id
      t.text :comment
      t.integer :state
      t.integer :ticket_id

      t.timestamps
    end
    add_index :registers, [:user_id]
    add_index :registers, [:stage_id]
    add_index :registers, [:type_id]
    add_index :registers, [:ticket_id]
  end
end
