class CreateColors < ActiveRecord::Migration[5.1]
  def change
    create_table :colors do |t|
      t.string :color_code, uniq: true, null: false
      t.string :color_name, uniq: true, null: false

      t.timestamps
    end
  end
end
