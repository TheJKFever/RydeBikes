class Bike < ActiveRecord::Base
	@@status = {
		:reserved => 'reserved',
		:available => 'available'
	}
	def self.status
		@@status
	end

	has_many :rides

	# validates :network_id, presence: true
	validates_associated :location

	belongs_to :network
	belongs_to :location, class_name: 'Coordinate', foreign_key: 'location_id'
	belongs_to :current_ride, class_name: 'Ride', foreign_key: 'ride_id'

	def as_json(options={})
		super(:only => [:id, :status, :model], :include => {:location => {:only => [:name, :full_address, :latitude, :longitude]}})
	end
end