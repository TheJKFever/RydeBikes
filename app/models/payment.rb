class Payment < ActiveRecord::Base
	has_one :user
	has_many :transactions
end
