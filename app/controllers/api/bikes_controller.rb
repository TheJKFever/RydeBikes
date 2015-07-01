class Api::BikesController < Api::ApiController
  before_action :set_bike, only: [:reserve, :return]

  respond_to :json

  # Takes in lat and long coord of user and radius
  # defaults to ipaddress location and 0.5 
  def index # returns all bikes within a certain radius
    ## TODO: use coordinates later, when more campuses and bikes.
    # # defaults radius to half mile, and coordinate to requesting ip address
    # radius = params[:radius] ? params[:radius] : 0.5
    # coordinates = params[:coordinates] ? params[:coordinates] : request.location
    # puts coordinates
    # @bikes = Coordinate.near(coordinates, radius).joins(:bikes)
    @bikes = Bike.where(status: Bike.status[:available])
    render json: @bikes
  end

  # Dont let a user reserve a bike unless they have
  # a payment method added and are in good standing
  #
  # Expected params:
  #   X-Api-Key: api_key
  #   id: bike_id
  def reserve # Start Ride
    validates_has_payment_and_good_standing
    render json: { error: "This bike is not available to reserve" } if @bike.status != Bike.status[:available]
    @bike.status = Bike.status[:reserved]
    @ride = Ride.create(
      user_id: @user.id, 
      bike_id: @bike.id, 
      start_location: @bike.location, 
      start_time: DateTime.now, 
      status: Ride.status[:progress])
    @bike.current_ride = @ride
    if @bike.save
      render json: @bike
    else
      render json: { error: @bike.errors.full_messages }
    end
  end

  # Expected params:
  #   X-Api-Key: api_key
  #   id: bike_id
  #   latitude: lat
  #   longitude: long
  #   payment_method_nonce: braintree token
  def return # End Ride
    @ride = @bike.current_ride
    render json: { error: 'Could not find ride in progress associated with this bike' }, status: 404 if @ride.nil?
    # This should never happen...
    render json: { error: 'Cannot return a bike that is not reserved' }, status: 401 if (@bike.status != Bike.status[:reserved])
    render json: { error: 'You are not the current owner of this bike' }, status: 401 if (@user != @ride.user)

    # TODO: get name for this location by nearest Coordinate with name...
    @location = Coordinate.find_or_initialize_by(latitude: params[:latitude], longitude: params[:longitude])
    render json: { error: @location.errors.full_messages } if !@location.valid?
    @location.save
    
    # end Ride
    @ride.stop_location = @location, 
    @ride.stop_time = DateTime.now, 
    @ride.status = Ride.status[:complete]
    render json: { error: @ride.errors.full_messages } if !@ride.valid?

    # Charge for ride
    if @user.service_type === User.service_type[:payperuse]
      if Transaction.charge_user_for_ride(@user, @ride)
        # TODO: Finish this
      else
        # TODO: What happens if transaction failse
        # @user.status === User.status[:badperson]
      end
    end

    @bike.status = Bike.status[:available]
    @bike.location = @location
    @bike.current_ride = nil
    render json: { error: @bike.errors.full_messages } if !@bike.valid?    

    @bike.save
    # TODO: make this @ride.summary
    render json: @ride.to_json if @ride.save
  end

  # def interest
  #   @location = Coordinate.find_or_initialize_by(name: params[:location])
  #   if @location.save
  #     @interest = Interest.new(user_id: @user, location: @location)
  #     if @interest.save
  #       render json: { success: true }
  #     else
  #       render json: { error: @interest.errors.full_messages }
  #     end
  #   else
  #     render json: { error: @location.errors.full_messages }
  #   end
  # end

  private
  def set_bike
    @bike = Bike.find(params[:id])
  end

  def bike_params
    params.require(:bike)
    .permit(:status, :model, :network => [:name], :location => [:id, :name, :full_address, :latitude, :longitude])
  end
end
