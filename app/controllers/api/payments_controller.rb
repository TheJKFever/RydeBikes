class PaymentsController < Api::ApiController
	# before_action :set_payment, only: [:show, :edit, :update, :destroy]

	respond_to :json

	def new
		render :json => generate_client_token 
	end

	private
	 
	def generate_client_token
	  Braintree::ClientToken.generate
	end

	def set_payment
		@payment = Transaction.find(params[:id])
		redirect_to home_path if (current_user != @payment.user || current_user.admin?)
	end

	def payment_params
		params.require(:payment).permit()
	end
end