class Bike < ActiveRecord::Base
	enum status: [:available, :reserved]

	has_many :rides
	belongs_to :network
	belongs_to :location, class_name: 'Coordinate', foreign_key: 'location_id'
	belongs_to :current_ride, class_name: 'Ride', foreign_key: 'ride_id'

	validates_associated :location
	validates_presence_of :status, :network
	validates_presence_of :current_ride, :if => :reserved?

	def serializable_hash(options={})
		options = {
			:only => [:id, :status, :model], :include => {:location => {:only => [:name, :full_address, :latitude, :longitude]}}
		}.update(options)
		super(options)
	end
end