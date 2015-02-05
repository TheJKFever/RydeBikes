class AddNameToCoordinate < ActiveRecord::Migration
  def change
  	add_column :coordinates, :name, :string
  	add_column :coordinates, :full_address, :string
  end
end
