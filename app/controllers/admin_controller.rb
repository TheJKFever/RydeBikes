class AdminController < ApplicationController
  before_action :authenticate_admin!

  def dashboard
    @bikes = Bike.all
    @current_rides = Ride.where(status: Ride.statuses[:progress]).order(:start_time)
  end

end