class AddColorCodeToType < ActiveRecord::Migration[5.1]
  def change
    add_column :types, :color_code, :string, unique: true
  end
end
