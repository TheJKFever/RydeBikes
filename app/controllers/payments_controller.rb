class PaymentsController < ApplicationController
	before_filter :authenticate_user!
	before_action :set_payment, only: [:show, :edit, :update, :destroy]

	respond_to :html, :json

	def index # returns all payments methods for a particular user
		@payments = Payment.find_by_user_id(current_user.id)
		respond_with(@payments)
	end

	def show
		respond_with(@payment)
	end

	def new
		@payment = Payment.new
		respond_with(@payment)
	end

	def edit
	end

	def create
		@payment = Payment.new(payment_params)
		@payment.save
		respond_with(@payment)
	end

	def update
		@payment.update(payment_params)
		respond_with(@payment)
	end

	def destroy
		@payment.destroy
		respond_with(@payment)
	end

	private
		def set_payment
			@payment = Payment.find(params[:id])
			redirect_to home_path if (current_user != @transaction.user || current_user.admin?)
		end

		def payment_params
			params.require(:payment).permit(:authentication_token, :user_id, :payment_type)
		end
end
