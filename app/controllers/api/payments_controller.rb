class Api::PaymentsController < Api::ApiController
	before_action :set_payment, only: [:show, :edit, :update, :destroy]

	def new
	end

	# get "/client_token" do
	#   Braintree::ClientToken.generate(
	#     :customer_id => a_customer_id
	#   )
	# end

end