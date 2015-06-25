class CreateCoordinates < ActiveRecord::Migration
  def change
    create_table :coordinates do |t|
      t.integer :network_id
      t.float :latitude
      t.float :longitude
      t.string :name
      t.string :full_address
    end
    # add_index :users, :access_token,         unique: true
    add_index :coordinates, :network_id
    add_index :coordinates, [:latitude, :longitude]
  end
end
