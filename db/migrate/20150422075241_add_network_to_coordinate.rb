class AddNetworkToCoordinate < ActiveRecord::Migration
  def change
  	add_column :coordinates, :network_id, :integer  	
  end
end
