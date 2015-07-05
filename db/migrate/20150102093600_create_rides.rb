class CreateRides < ActiveRecord::Migration
  def change
    create_table :rides do |t|
      t.integer :bike_id
      t.integer :user_id
      t.integer :start_location_id
      t.integer :stop_location_id
      t.datetime :start_time
      t.datetime :stop_time
      t.string :status
      t.timestamps null: false
    end
    add_index :rides, :user_id
    add_index :rides, :bike_id
    add_index :rides, :stop_time
    add_index :rides, [:user_id, :status]
  end
end