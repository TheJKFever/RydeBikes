class Api::BikesController < Api::ApiController
  before_action :set_bike, only: [:reserve, :return]
  skip_before_action :authenticate_apiKey, only: [:pulse]

  # Takes in lat and long coord of user and radius
  # defaults to ipaddress location and 0.5 
  def index # returns all bikes within a certain radius
    ## TODO: use coordinates later, when more campuses and bikes.
    # # defaults radius to half mile, and coordinate to requesting ip address
    # radius = params[:radius] ? params[:radius] : 0.5
    # coordinates = params[:coordinates] ? params[:coordinates] : request.location
    # puts coordinates
    # @bikes = Coordinate.near(coordinates, radius).joins(:bikes)
    @bikes = Bike.available
    render json: @bikes
  end

  # POST /api/bikes/reserve/:id
  # Dont let a user reserve a bike unless they have
  # a payment method added and are in good standing
  #
  # Expected params:
  #   X-Api-Key: api_key
  def reserve # Start Ride
    return render json: { error: "This bike is not available to reserve" }, status: :forbidden unless @bike.available?
    begin
      ActiveRecord::Base.transaction do
        @bike.current_ride = Ride.build_from_user_bike(@user, @bike)
        @bike.reserved!
        case params[:payment_type]
        when "subscription"
          render json: { error: "Subscription has not been implemented yet" }, status: :bad_request
          raise ActiveRecord::Rollback
        when "prepay"
          @user.validates_payment_and_good_standing
          @bike.current_ride.trans = Transaction.charge_user_for_ride(@user, @bike.current_ride, "prepay")
        else # :per_minute
          # put pay_per_minute logic here
        end
        @bike.save!

        print "Reserved Bike #{@bike.id} - scheduling bike-reserved-email"
        puts Time.now
        minutes = 10
        delay = "#{minutes}s"
        Rufus::Scheduler.singleton.in delay do
          if (Ride.find(@bike.current_ride.id).progress?)
            ApplicationMailer.bikes_been_reserved_for(minutes, @user, @bike.id).deliver_now
            print "Sent email "
            puts Time.now
          end
        end

      end
    rescue User::PaymentMethodException, User::BraintreeException => e
      render json: { error: e.message }, 
        status: :payment_required, 
        location: api_new_payment_path
    rescue User::NotInGoodStandingException => e
      render json: { error: e.message }, 
        status: :forbidden, 
        location: api_collections_path
    rescue ActiveRecord::RecordInvalid => e
      render :json => { :error => e.message }, 
        status: :unprocessable_entity
    rescue Transaction::Rejected => e
      render :json => { :error => e.message }, 
        status: :bad_request
    else
      render json: {bike: @bike.to_json({methods: :code}), transction: @bike.current_ride.trans}
    end
  end

  # POST /api/bikes/return/:id
  # Expected params:
  #   X-Api-Key: api_key
  #   latitude: lat
  #   longitude: long
  #   payment_method_nonce: braintree token
  def return # End Ride
    params.require(:latitude)
    params.require(:longitude)
    @ride = @bike.current_ride
    return render json: { error: 'Could not find the current ride associated with this bike' }, status: :not_found if @ride.nil?
    return render json: { error: 'Cannot return a bike that is not reserved' }, status: :forbidden unless (@bike.reserved?)
    return render json: { error: 'You are not the current owner of this bike' }, status: :forbidden if (@user != @ride.user)

    # TODO: get name for this location by nearest Coordinate with name...
    @location = Coordinate.find_or_initialize_by(latitude: params[:latitude], longitude: params[:longitude])
    render :json => { :error => @location.errors.full_messages } unless @location.save
    
    @ride.stop_location = @location
    @ride.stop_time = DateTime.now
    @ride.status = Ride.statuses[:complete]
    return render :json => { :error => @ride.errors.full_messages } unless @ride.save

    # CHARGE FOR RIDE
    begin
      # TODO: Finish this
      # @transaction = Transaction.charge_user_for_ride(@user, @ride)
      # @transaction.save!
    # put specific rescues here
    rescue Exception => e
      return render json: { error: e }, status: :internal_server_error
      # TODO: What happens if transaction fails
      # @user.status === User::STATUS[:outstanding]
    ensure
      @bike.location = @location
      @bike.current_ride = nil
      @bike.status = Bike.statuses[:available]
      return render json: { error: @bike.errors.full_messages } unless @bike.save
    end
    # TODO: make this @ride.summary
    render :json => @ride.to_json if @ride.save
  end

  # def interest
  #   @location = Coordinate.find_or_initialize_by(name: params[:location])
  #   if @location.save
  #     @interest = Interest.new(user_id: @user, location: @location)
  #     if @interest.save
  #       render :json => { success: true }
  #     else
  #       render :json => { :error => @interest.errors.full_messages }
  #     end
  #   else
  #     render :json => { :error => @location.errors.full_messages }
  #   end
  # end

  def pulse
    render :json => params, :status => :ok
  end

  private

  def set_bike
    @bike = Bike.find(params[:id])
  end

  def bike_params
    params.require(:bike)
    .permit(:status, :model, :network => [:name], :location => [:id, :name, :full_address, :latitude, :longitude])
  end
end