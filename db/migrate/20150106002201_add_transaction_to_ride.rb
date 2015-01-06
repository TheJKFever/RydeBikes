class AddTransactionToRide < ActiveRecord::Migration
  def change
  	add_column :rides, :transaction_id, :integer
  end
end
