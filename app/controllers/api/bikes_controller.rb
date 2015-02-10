class Api::BikesController < ApplicationController
  skip_before_filter :verify_authenticity_token
	before_filter :authenticate_apiKey
  before_action :set_bike, except: [:index]
  before_filter :set_headers

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

  def update
    @bike.update(bike_params)
    respond_with(@bike)
  end

  def reserve 
    render json: { error: "This bike is not available to reserve" } if (!@bike.status==Bike.status[:available])
    @bike.status = Bike.status[:reserved]
    @ride = Ride.create(user_id: @user.id, bike_id: @bike.id, start_location: @bike.location, start_time: DateTime.now, status: Ride.status[:progress])
    @bike.current_ride = @ride
    @bike.save
    render json: @ride
  end

  def return
    @ride = @bike.current_ride
    render json: { error: 'This bike is currently available' } if (!@bike.status==Bike.status[:reserved])
    render json: { error: 'You are not the current owner of this bike' } if (@user!=@ride.user)
    # Change this to name and network
    @location = Coordinate.find_or_initialize_by(name: params[:bike][:location][:name])
    if @location.save
      if @ride.update(stop_location: @location, stop_time: DateTime.now, status: Ride.status[:complete])
        # if bike reserved, find most recent bike
        @bike.status = Bike.status[:available]
        @bike.current_ride = nil
        if @bike.save
          render json: @bike
        else
          render json: { error: @bike.errors.full_messages }
        end
      else
        render json: { error: @ride.errors.full_messages }
      end
    else
        render json: { error: @location.errors.full_messages }
    end
  end

  private
  def set_bike
    @bike = Bike.find(params[:id])
  end

	def authenticate_apiKey
    puts params
    if (apiKey = ApiKey.find_by_access_token(params['apiKey']))
      @user = apiKey.user
    else
      render json: { errors: "Invalid apiKey" }
    end
	end

  def set_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Expose-Headers'] = 'ETag'
    headers['Access-Control-Allow-Methods'] = 'GET, POST, PATCH, PUT, DELETE, OPTIONS, HEAD'
    headers['Access-Control-Allow-Headers'] = '*,x-requested-with,Content-Type,If-Modified-Since,If-None-Match'
    headers['Access-Control-Max-Age'] = '86400'
  end  

  def bike_params
    params.require(:bike)
    .permit(:status, :model, :network => [:name], :location => [:id, :name, :full_address, :latitude, :longitude])
  end

end
