class CreateBikes < ActiveRecord::Migration
  def change
    create_table :bikes do |t|
      t.string :status
      t.integer :ride_id #current_ride
      t.integer :location_id
      t.string :model
      t.integer :network_id
      t.timestamps null: false
    end
    add_index :bikes, :status
    add_index :bikes, :network_id
    add_index :bikes, :ride_id
    add_index :bikes, :location_id    
  end
end
