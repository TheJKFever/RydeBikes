class CreateTransactions < ActiveRecord::Migration
	def change
		create_table :transactions do |t|
			t.integer :payment_id
			t.string :status
			t.timestamps null: false
		end
	end
end
