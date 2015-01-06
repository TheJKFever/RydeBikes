class NetworksController < ApplicationController
	before_filter :authenticate_user!
	before_filter :authenticate_admin!, :except => [:index, :show]
	before_action :set_network, only: [:show, :edit, :update, :destroy]

	respond_to :html, :json

	def index # returns all networks and the number of users in each (user_count)
		Network.joins(:users).select("networks.*, COUNT(*) AS user_count").group("networks.name")
		@networks = Network.all
		respond_with(@networks)
	end

	def show
		respond_with(@network)
	end

	def new
		@network = Network.new
		respond_with(@network)
	end

	def edit
	end

	def create
		@network = Network.new(network_params)
		@network.save
		respond_with(@network)
	end

	def update
		@network.update(network_params)
		respond_with(@network)
	end

	def destroy
		@network.destroy
		respond_with(@network)
	end

	private
		def set_network
			@network = Network.find(params[:id])
		end

		def network_params
			params.require(:network).permit(:name, :domain)
		end
end
