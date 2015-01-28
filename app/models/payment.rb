class Payment < ActiveRecord::Base
	has_one :user
	has_many :trans, class_name: "Transaction"
end
