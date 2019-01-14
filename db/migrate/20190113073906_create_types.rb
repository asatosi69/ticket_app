class CreateTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :types do |t|
      t.string :type
      t.integer :seat

      t.timestamps
    end
  end
end
