class BikesController < ApplicationController
  before_filter :authenticate_user!
	before_filter :authenticate_admin!, except: [:index, :show, :reserve]
  before_action :set_bike, except: [:index, :create, :new]

  # AVAILABLE TO USERS

  def index # returns all bikes within a certain radius
    ## TODO: use coordinates later, when more campuses and bikes.
    # # defaults radius to half mile, and coordinate to requesting ip address
    # radius = params[:radius] ? params[:radius] : 0.5
    # coordinates = params[:coordinates] ? params[:coordinates] : request.location
    # puts coordinates
    # @bikes = Coordinate.near(coordinates, radius).joins(:bikes)
    @bikes = Bike.all
    render json: @bikes
  end

  def show
    render json: @bike
  end

  def reserve 
    @bike.status = Bike::STATUS[:reserved]
    if @bike.save
      if @ride = Ride.create(
          user: current_user,
          bike_id: @bike.id,
          start_location: @bike.location, 
          start_time: DateTime.now, 
          status: Ride::STATUS[:progress])
        render json: @ride
      else
        render json: { error: @ride.errors.full_messages }
      end
    else
      render json: { error: @bike.errors.full_messages }
    end
  end

  # AVAILABLE ONLY TO ADMIN 

  def new
    @bike = Bike.new
    render json: @bike
  end

  def edit
    render json: @bike
  end

  def create
    @bike = Bike.new(bike_params)
    if @bike.save
      render json: @bike
    else 
      render json: { error: @bike.errors.full_messages }
    end
  end

  def update
    if @bike.update(bike_params)
      render json: @bike
    else 
      render json: { error: @bike.errors.full_messages }
    end
  end

  def destroy
    if @bike.destroy
      render json: @bike
    else
      render json: { error: @bike.errors.full_messages }
    end
  end

  private
  def set_bike
    @bike = Bike.find(params[:id])
  end

  def bike_params
    params.require(:bike)
    .permit(:status, :model, :network => [:name], :location => [:name, :full_address, :latitude, :longitude])
  end
end