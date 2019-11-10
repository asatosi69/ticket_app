class AddFuriganaToRegister < ActiveRecord::Migration[5.1]
  def change
    add_column :registers, :furigana, :string
  end
end
