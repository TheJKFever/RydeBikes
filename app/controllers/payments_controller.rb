class PaymentsController < ApplicationController
	before_filter :authenticate_user!
	before_action :set_payment, only: [:show, :edit, :update, :destroy]

	respond_to :json

	def index # returns all payments methods for a particular user
		@payments = Payment.find_by_user_id(current_user.id)
		render json: @payments
	end

	def show
		render json: @payment
	end

	def new
		@payment = Payment.new
		render json: @payment
	end

	def edit
		render json: @payment
	end

	def create
		@payment = Payment.new(payment_params)
		if @payment.save
			render json: @payment
		else
			render json: { error: @payment.errors.full_messages }
		end
	end

	def update
		if @payment.update(payment_params)
			render json: @payment
		else
			render json: { error: @payment.errors.full_messages }
		end
	end

	def destroy
		@payment.destroy
	end

	private
		def set_payment
			@payment = Payment.find(params[:id])
			redirect_to home_path if (current_user != @payment.user || current_user.admin?)
		end

		def payment_params
			params.require(:payment).permit(:authentication_token, :user_id, :payment_type)
		end
end
