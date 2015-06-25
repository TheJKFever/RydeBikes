class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :apt
      t.string :city
      t.string :zipcode
      t.string :state
    end
  end
end
