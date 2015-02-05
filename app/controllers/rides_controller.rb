class RidesController < ApplicationController
	# before_filter :authenticate_user!
	before_action :set_ride, only: [:show, :edit, :finish, :update, :destroy]

	respond_to :json

	def index # returns all rides methods for a particular user
		@rides = current_user.admin? Ride.all : Ride.find_by_user_id(current_user.id)
		respond_with(@rides)
	end

	def show
		respond_with(@ride)
	end

	def new
		@ride = Ride.new
		respond_with(@ride)
	end

	def edit
	end

	def create
		@ride = Ride.new(ride_params)
		if @ride.save
			@bike = @ride.bike
			@bike.status = Bike.status[:reserved]
		respond_with(@ride)
	end

	def finish
		if @ride.update(ride_params)
			@bike = @ride.bike
			@bike.model = @ride.stop_location # TODO: change this to location (only for test 0)

	end

	def update
		@ride.update(ride_params)
		respond_with(@ride)
	end

	def destroy
		@ride.destroy
		respond_with(@ride)
	end

	private
		def set_ride
			@ride = Ride.find(params[:id])
			redirect_to home_path if (current_user != @transaction.user || current_user.admin?)
		end

		def ride_params
			params.require(:ride)
			.permit(:bike_id, :user_id, :start_location, :stop_location, 
					:start_time, :stop_time, :status, :transaction_id)
		end
end