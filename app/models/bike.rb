class Bike < ActiveRecord::Base
	STATUS = {
		:reserved => 'reserved',
		:available => 'available'
	}

	has_many :rides
	belongs_to :network
	belongs_to :location, class_name: 'Coordinate', foreign_key: 'location_id'
	belongs_to :current_ride, class_name: 'Ride', foreign_key: 'ride_id'

	validates_associated :location
	validates_presence_of :status, :network
	validates_presence_of :current_ride, :if => :reserved?

	def reserved?
		status == @@status[:reserved]
	end

	def as_json(options={})
		super(:only => [:id, :status, :model], :include => {:location => {:only => [:name, :full_address, :latitude, :longitude]}})
	end
end