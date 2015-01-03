class Transaction < ActiveRecord::Base
	belongs_to :payment
end
