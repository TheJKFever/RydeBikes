class RidesController < ApplicationController
	before_filter :authenticate_user!
	before_action :set_ride, only: [:show, :edit, :update, :destroy]

	respond_to :html, :json

	def index # returns all rides methods for a particular user
		@rides = Ride.find_by_user_id(current_user.id)
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
		@ride.save
		respond_with(@ride)
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