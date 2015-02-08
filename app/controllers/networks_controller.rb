class NetworksController < ApplicationController
	before_filter :authenticate_user!
	before_filter :authenticate_admin!, :except => [:index, :show]
	before_action :set_network, only: [:show, :edit, :update, :destroy]

	respond_to :json

  # AVAILABLE TO USERS

	def index # returns all networks and the number of users in each (user_count)
		# Consider changing this to a networks_domains table
		# @networks = Network.joins(:users).select("networks.name, COUNT(*) AS user_count").group("networks.name")
		# @networks = Network.joins("LEFT OUTER JOIN users ON network.id = users.network_id").select("networks.*, COUNT(*) AS user_count").group("networks.name")
		@networks = Network.includes(:users).select("networks.name, COUNT(*) AS user_count").group("networks.name")
		render json: @networks
	end

	def show
		render json: @network
	end

  # AVAILABLE ONLY TO ADMIN 	

	def new
		@network = Network.new
		render json: @network
	end	

	def edit
		render json: @network
	end

	def create
		@network = Network.new(network_params)
		if @network.save
			render json: @network
		else
			render json: { error: @network.errors.full_messages }
		end
	end

	def update
		if @network.update(network_params)
			render json: @network
		else
			render json: { error: @network.errors.full_messages }
		end
	end

	def destroy
		@network.destroy
	end

	private
	def set_network
		@network = Network.find(params[:id])
	end

	def network_params
		params.require(:network).permit(:name, :domain)
	end
end
