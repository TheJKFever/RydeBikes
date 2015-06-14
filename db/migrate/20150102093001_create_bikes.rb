class CreateBikes < ActiveRecord::Migration
  def change
    create_table :bikes do |t|
		t.string :status
  		t.integer :network_id
		t.integer :location_id
		t.string :model
		t.integer :ride_id
      	t.timestamps null: false
    end
  end
end
