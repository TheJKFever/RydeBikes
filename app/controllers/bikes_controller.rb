class BikesController < ApplicationController
  before_filter :authenticate_user!, except: [:show, :reserve, :index] # TODO: change this back and use API authentication instead
	before_filter :authenticate_admin!, except: [:index, :show, :reserve]
  before_action :set_bike, except: [:index, :create]

  respond_to :json

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

  def new
    @bike = Bike.new
    respond_with(@bike)
  end

  def edit
  end

  def create
    @bike = Bike.new(bike_params)
    @bike.save
    respond_with(@bike)
  end

  def update
    @bike.update(bike_params)
    respond_with(@bike)
  end

  def destroy
    @bike.destroy
    respond_with(@bike)
  end

  def reserve 
    # TODO: pass in user
    # 
    @bike.status = Bike.status[:reserved]
    @bike.save
    @ride = Ride.create(bike_id: @bike.id, start_location: @bike.location, start_time: DateTime.now, status: Ride.status[:progress])
    respond_with(@ride)
  end

  private
  def set_bike
    @bike = Bike.find(params[:id])
  end

  def bike_params
    params.require(:bike)
    .permit(:status, :model, :network => [:name], :location => [:latitude, :longitude])
  end
end