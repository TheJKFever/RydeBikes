class BikesController < ApplicationController
  before_filter :authenticate_user!
	before_filter :authenticate_admin!, :except => [:index, :show]
  before_action :set_bike, only: [:show, :edit, :update, :destroy]

  respond_to :html, :json

  def index # returns all bikes within a certain radius
    # defaults raius to half mile, and coordinate to requesting ip address
    radius = if params[:radius] ? params[:radius] : 0.5
    coordinates = if params[:coordinates] ? params[:coordinates] : request.location
    @bikes = Coordinate.near(coordinates, radius).joins(:bikes)
    respond_with(@bikes)
  end

  def show
    respond_with(@bike)
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

  private
    def set_bike
      @bike = Bike.find(params[:id])
    end

    def bike_params
      params.require(:bike)
      .permit(:status, :model, :network => [:name], :location => [:latitude, :longitude])
    end
end
