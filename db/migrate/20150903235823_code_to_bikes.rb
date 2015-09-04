class CodeToBikes < ActiveRecord::Migration
  def change
    add_column :bikes, :code, :string
  end
end
