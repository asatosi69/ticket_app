class CreateTickets < ActiveRecord::Migration[5.1]
  def change
    create_table :tickets do |t|
      t.references :user, foreign_key: true
      t.references :performance, foreign_key: true
      t.references :kind, foreign_key: true
      t.integer :count
      t.string :b_name
      t.string :b_mail
      t.text :comment

      t.timestamps
    end
  end
end
