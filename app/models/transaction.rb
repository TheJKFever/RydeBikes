class Transaction < ActiveRecord::Base
	belongs_to :payment
	has_one :ride
end
