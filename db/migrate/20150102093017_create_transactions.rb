class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :payment_id
      t.string :payment_type
      t.integer :user_id
      t.integer :ride_id
      t.float :amount
      t.string :status
      t.string :details
      t.timestamps null: false
    end
    add_index :transactions, :payment_id
    add_index :transactions, :user_id
    add_index :transactions, :ride_id
  end
end
