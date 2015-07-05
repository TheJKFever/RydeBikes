class CreateNetwork < ActiveRecord::Migration
  def change
    create_table(:networks) do |t|
      t.string :name
      t.string :domain
    end
    add_index :networks, :domain
  end
end
