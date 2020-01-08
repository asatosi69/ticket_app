class CreateTickets < ActiveRecord::Migration[5.1]
  def change
    create_table :tickets do |t|
      t.references :user
      t.references :performance
      t.references :kind
      t.integer :count
      t.string :b_name
      t.string :b_mail
      t.text :comment

      t.timestamps
    end
  end
end
