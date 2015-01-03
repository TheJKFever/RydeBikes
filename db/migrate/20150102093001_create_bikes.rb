class CreateBikes < ActiveRecord::Migration
  def change
    create_table :bikes do |t|
			t.string :status
			t.integer :location
			t.string :model
      t.timestamps null: false
    end
  end
end
