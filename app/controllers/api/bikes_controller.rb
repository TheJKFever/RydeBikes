class Api::BikesController < ApplicationController
	before_filter :authenticate_apiKey
  before_action :set_bike, except: [:index]

  respond_to :json

  def index # returns all bikes within a certain radius
    ## TODO: use coordinates later, when more campuses and bikes.
    # # defaults radius to half mile, and coordinate to requesting ip address
    # radius = params[:radius] ? params[:radius] : 0.5
    # coordinates = params[:coordinates] ? params[:coordinates] : request.location
    # puts coordinates
    # @bikes = Coordinate.near(coordinates, radius).joins(:bikes)
    @bikes = Bike.all
    render json: @bikes(:include => {:location})
  end

  def show
    render json: @bike
  end

  def update
    @bike.update(bike_params)
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

	def authenticate_apiKey
    puts params
    if (apiKey = ApiKey.find_by_access_token(params['apiKey']))
      user = apiKey.user
    else
      render json: { errors: "Invalid apiKey" }
    end
	end

  def bike_params
    params.require(:bike)
    .permit(:status, :model, :network => [:name], :location => [:latitude, :longitude])
  end
end
