class Ride < ActiveRecord::Base
	@@status = {
		:progress => "in progress",
		:complete => "complete"
	}
	def self.status
		@@status
	end

	validates :bike_id, :start_location_id, :start_time, presence: true
	validates :stop_location_id, :stop_time, presence: true, if: :status_complete?

	belongs_to :tran, class_name: "Transaction"
	belongs_to :bike
	belongs_to :user
	belongs_to :start_location, class_name: 'Coordinate', foreign_key: "start_location_id"
	belongs_to :stop_location, class_name: 'Coordinate', foreign_key: "stop_location_id"

	def status_complete?
		return (self.status == @@status[:complete])
	end

	def as_json(options={})
		super(:only => [:id, :bike_id, :start_time, :stop_time, :status, :transaction_id], 
			:include => {
				:user => {:only => [:name, :email]}, 
				:start_location => {:only => [:name]}, 
				:stop_location => {:only => [:name]}
			})
	end
end