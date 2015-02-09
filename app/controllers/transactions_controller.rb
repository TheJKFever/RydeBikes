class TransactionsController < ApplicationController
	before_filter :authenticate_user!
	before_filter :authenticate_admin!, :except => [:index, :show, :new, :create]
	before_action :set_transaction, only: [:show, :edit, :update, :destroy]

	respond_to :json

  # AVAILABLE TO USERS
	def index # returns all transactions methods for a particular user
		if current_user.admin?
			@transactions = Transaction.all
		else
			@transactions = Transaction.find_by_user_id(current_user.id)
		end
		render json: @transactions
	end

	def show
		render json: @transaction
	end

	def new
		@transaction = Transaction.new
		render json: @transaction
	end

	def create # TODO: Add Stripe api
		@transaction = Transaction.new(transaction_params)
		if @transaction.save
			render json: @transaction
		else
			render json: { error: @transaction.errors.full_messages }
		end
	end

	# AVAILABLE ONLY TO ADMIN 

	def edit
		render json: @transaction
	end

	def update
		if @transaction.update(transaction_params)
			render json: @transaction
		else
			render json: { error: @transaction.errors.full_messages }
		end
	end

	def destroy
		@transaction.destroy
	end

	private
	def set_transaction
		@transaction = Transaction.find(params[:id])
		redirect_to home_path if (current_user != @transaction.user || current_user.admin?)
	end

	def transaction_params
		params.require(:transaction)
		.permit(:status, :ride, :amount, :payment => [:user_id, :payment_type])
			#, :authentication_token
	end
end