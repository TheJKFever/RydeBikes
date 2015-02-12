class CreateInterests < ActiveRecord::Migration
  def change
    create_table :interests do |t|
      t.integer :user_id
      t.integer :location_id
      t.timestamps null: false
    end
  end
end
