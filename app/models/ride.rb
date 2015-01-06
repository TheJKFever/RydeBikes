class Ride < ActiveRecord::Base
	belongs_to :transaction
	belongs_to :bike
	belongs_to :user
	belongs_to :coordinate, foreign_key: "start_location"
	belongs_to :coordinate, foreign_key: "stop_location"
end
