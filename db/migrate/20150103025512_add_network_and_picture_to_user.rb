class AddNetworkAndPictureToUser < ActiveRecord::Migration
  def change
  	create_table(:networks) do |t|
  		t.string :name
  		t.string :domain
  	end

  	add_column :bikes, :network_id, :integer  	
  	add_column :users, :network_id, :integer
  	add_column :users, :picture, :string
  end
end
