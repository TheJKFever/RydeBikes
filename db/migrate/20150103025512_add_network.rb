class AddNetwork < ActiveRecord::Migration
  def change
  	create_table(:networks) do |t|
  		t.string :name
  		t.string :domain
  	end
  end
end
