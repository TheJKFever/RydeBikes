class Ride < ActiveRecord::Base

	enum status: [:complete, :progress]

	validates_presence_of :bike_id, :start_location_id, :start_time
	validates_presence_of :stop_location_id, :stop_time, if: :complete?

	has_one    :trans, class_name: 'Transaction'
	belongs_to :bike
	belongs_to :user
	belongs_to :start_location, class_name: 'Coordinate', foreign_key: 'start_location_id'
	belongs_to :stop_location, class_name: 'Coordinate', foreign_key: 'stop_location_id'

	def self.build_from_user_bike(user, bike)
    new(
	    user_id: user.id, 
	    bike_id: bike.id, 
	    start_location: bike.location, 
	    start_time: DateTime.now, 
	    status: statuses[:progress])
	end

	def calculate_cost
		return (self.stop_time - self.start_time) * 24 * 60 * COST_PER_MINUTE
	end

	def summary
		# TODO: return json of summary of ride, miles, etc.
		@summary = {
			:duration => (self.stop_time - self.start_time),
			:miles 	  => 1 # distance(self.start_location - self.stop_location)
		}
		return @summary.merge(self.to_json)
	end

	def serializable_hash(options={})
		super({
			:only => [:id, :bike_id, :start_time, :stop_time, :status, :transaction_id], 
			:include => {
				:user => {:only => [:name, :email]}, 
				:start_location => {:only => [:name, :latitude, :longitude]}, 
				:stop_location => {:only => [:name, :latitude, :longitude]}
			}
		}.merge(options || {}))
	end
end