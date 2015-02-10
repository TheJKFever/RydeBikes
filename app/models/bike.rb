class Bike < ActiveRecord::Base
	has_many :rides
	belongs_to :network
	belongs_to :location, class_name: 'Coordinate', foreign_key: 'location_id'
	belongs_to :current_ride, class_name: 'Ride', foreign_key: 'ride_id'

	@@status = {
		:reserved => 'reserved',
		:available => 'available'
	}
	def self.status
		@@status
	end

	def as_json(options={})
		super(:only => [:status, :model], :include => {:location => {:only => [:name, :full_address]}})
	end
end