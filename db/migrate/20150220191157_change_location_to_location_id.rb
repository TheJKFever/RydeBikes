class ChangeLocationToLocationId < ActiveRecord::Migration
  def change
  	rename_column :rides, :start_location, :start_location_id
  	rename_column :rides, :stop_location, :stop_location_id
  end
end
