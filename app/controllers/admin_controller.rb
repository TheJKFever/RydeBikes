class AdminController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_bike, only: [:release]

  def dashboard
    @bikes = Bike.all
    @current_rides = Ride.where(status: Ride.statuses[:progress]).order(:start_time)
  end


  ## /bikes/..

  # POST /admin/release/:id
  def release # End Ride
    @ride = @bike.current_ride
    return render json: { error: 'Cannot release a bike that is not reserved' }, status: :forbidden unless (@bike.reserved?)
    return render json: { error: 'This bike is reserved, but has no ride currently associated with it...' }, status: :not_found if @ride.nil?

    @ride.stop_location = @ride.start_location
    @ride.stop_time = DateTime.now
    @ride.status = Ride.statuses[:complete]
    return render :json => { :error => @ride.errors.full_messages } unless @ride.save

    @bike.location = @location
    @bike.current_ride = nil
    @bike.status = Bike.statuses[:available]
    return render json: { error: @bike.errors.full_messages } unless @bike.save

    redirect_to "dashboard", :alert => "Released Bike #{@bike.id}"
  end

  private
  def set_bike
    @bike = Bike.find(params[:id])
  end
end