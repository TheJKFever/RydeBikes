class Api::RidesController < Api::ApiController
	before_action :set_ride, except: [:index]

	def index # returns all rides methods for a particular user
		@rides = @user.admin? ? Ride.all : Ride.find_by_user_id(@user.id)
		render :json => @rides
	end

	def show
		render :json => @ride
	end

	def create
		@ride = Ride.new(ride_params)
		if @ride.save
			@bike = @ride.bike
			@bike.status = Bike::STATUS[:reserved]
			render :json => @ride
		else
			render :json => { :error => "Could not create new ride" }
		end
	end

	def finish
		if @ride.update(ride_params)
			@bike = @ride.bike
			@bike.location = @ride.stop_location
			if @bike.save
				render :json => @ride
			else
				render :json => { :error => "Could not update bike location" }
			end
		else
			render :json => { :error => "Could not update ride" }
		end
	end

	def update
		@ride.update(ride_params)
		render :json => @ride
	end

	# def destroy
	# 	@ride.destroy
	# 	render :json => { success: "cancelled ride" }
	# end

	private
	def set_ride
		@ride = Ride.find(params[:id])
	end		

	def ride_params
		params.require(:ride)
		.permit(:bike_id, :user_id, :start_location, :stop_location, 
				:start_time, :stop_time, :status, :transaction_id)
	end
end
