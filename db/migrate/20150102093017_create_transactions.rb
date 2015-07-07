class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :cc_id # credit_card_details[unique_number_identifier] from BT optional
      t.string  :payment_type # payment_instrument_type from BT
      t.integer :user_id
      t.integer :ride_id
      t.float   :amount
      t.string  :status
      t.string  :details
      t.timestamps null: false
    end
    add_index :transactions, :user_id
    add_index :transactions, :ride_id
  end
end
