class CreateCoordinates < ActiveRecord::Migration
	def change
		create_table :coordinates do |t|
			t.float :latitude
			t.float :longitude
  			t.integer :network_id
  			t.string :name
  			t.string :full_address
		end
	end
end