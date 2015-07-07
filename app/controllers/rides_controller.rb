class RidesController < ApplicationController
	before_action :authenticate_user!
	before_action :set_ride, only: [:show, :edit, :finish, :update, :destroy]

	respond_to :json

	def index # returns all rides methods for a particular user
		if current_user.admin?
			@rides = Ride.all
		else
			@rides = Ride.find_by_user_id(current_user.id)
		end
		render json: @rides
	end

	def show
		render json: @ride
	end

	def new
		@ride = Ride.new
		render json: @ride
	end

	def edit
		render json: @ride
	end

	def create # Same exact method at bikes#reserve
		@ride = Ride.new(ride_params)
		if @ride.save
			@bike = @ride.bike
			if @bike.update(status: Bike::STATUS[:reserved])
				render json: @ride
			else
				render json: { error: @bike.errors.full_messages }
			end
		else
			render json: { error: @ride.errors.full_messages }
		end
	end

	def finish
		if @ride.update(ride_params)
			@bike = @ride.bike
			if @bike.update(location: @ride.stop_location)
				render json: @ride
			else
				render json: { error: @bike.errors.full_messages }
			end
		else
			render json: { error: @ride.errors.full_messages }
		end
	end

	def update
		if @ride.update(ride_params)
			render json: @ride
		else
			render json: { error: @ride.errors.full_messages }
		end
	end

	def destroy
		@ride.destroy
	end

	private
		def set_ride
			@ride = Ride.find(params[:id])
			redirect_to home_path if (current_user != @ride.user || current_user.admin?)
		end

		def ride_params
			params.require(:ride)
			.permit(:bike_id, :user_id, :start_location, :stop_location, 
					:start_time, :stop_time, :status, :transaction_id)
		end
end