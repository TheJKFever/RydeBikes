class CurrentRideToBike < ActiveRecord::Migration
  def change
  	add_column :bikes, :ride_id, :integer
  end
end
