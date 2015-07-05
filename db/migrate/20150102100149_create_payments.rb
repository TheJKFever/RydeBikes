class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
    	t.string :token
    	t.integer :user_id
      # Braintree stores default payment
    	# t.boolean :default, default: true
    	t.string :status
    	t.string :payment_type
      t.timestamps null: false
    end
    add_index :payments, :user_id
    add_index :payments, :token    
  end
end
