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
	end
end
