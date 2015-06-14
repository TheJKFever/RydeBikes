class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
    	t.string :token
    	t.integer :user_id

      # Use if adding many payment
    	# t.boolean :default, default: true

    	t.string :status
    	t.string :payment_type
      t.timestamps null: false
    end
  end
end
