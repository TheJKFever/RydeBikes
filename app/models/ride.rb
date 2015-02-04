class Ride < ActiveRecord::Base
	belongs_to :tran, class_name: "Transaction"
	belongs_to :bike
	belongs_to :user
	belongs_to :coordinate, foreign_key: "start_location"
	belongs_to :coordinate, foreign_key: "stop_location"

	@@status = {
		:progress => "in progress",
		:complete => "complete"
	}
	def self.status
		@@status
	end
end