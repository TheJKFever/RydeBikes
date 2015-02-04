class Bike < ActiveRecord::Base
	has_many :rides
	belongs_to :network
	belongs_to :coordinate, foreign_key: "location"

	@@status = {
		:reserved => 'reserved',
		:available => 'available'
	}
	def self.status
		@@status
	end
end
