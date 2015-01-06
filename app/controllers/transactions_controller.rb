class TransactionsController < ApplicationController
	before_filter :authenticate_user!
	before_filter :authenticate_admin!, :only => [:edit, :update, :destroy]
	before_action :set_transaction, only: [:show, :edit, :update, :destroy]

	respond_to :html, :json

	def index # returns all transactions methods for a particular user
		@transactions = Transaction.find_by_user_id(current_user.id)
		respond_with(@transactions)
	end

	def show
		respond_with(@transaction)
	end

	def new
		@transaction = Transaction.new
		respond_with(@transaction)
	end

	def edit
	end

	def create
		@transaction = Transaction.new(transaction_params)
		@transaction.save
		respond_with(@transaction)
	end

	def update
		@transaction.update(transaction_params)
		respond_with(@transaction)
	end

	def destroy
		@transaction.destroy
		respond_with(@transaction)
	end

	private
		def set_transaction
			@transaction = Transaction.find(params[:id])
			redirect_to home_path if (current_user != @transaction.user || current_user.admin?)
		end

		def transaction_params
			params.require(:transaction)
			.permit(:status, :payment => [:user_id, :payment_type
				#, :authentication_token
				])
		end
end
