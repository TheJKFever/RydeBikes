class CreateJoinTablePaymentUser < ActiveRecord::Migration
  def change
    create_join_table :payments, :users do |t|
      # t.index [:payment_id, :user_id]
      # t.index [:user_id, :payment_id]
    end
  end
end
