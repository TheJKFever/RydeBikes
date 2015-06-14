class TransactionsController < Api::ApiController
	before_action :set_transaction, only: [:show, :edit, :update, :destroy]

	respond_to :json

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
		@braintree_token = generate_client_token
		@transaction = Tr€ansaction.new
		render json: @transaction
	end

	def create
	    @result = Braintree::Transaction.sale(
	              amount: current_user.cart_total_price,
	              payment_method_nonce: params[:payment_method_nonce])
	    if @result.success?
	      current_user.purchase_cart_movies!
	      redirect_to root_url, notice: "Congraulations! Your transaction has been successfully!"
	    else
	      flash[:alert] = "Something went wrong while processing your transaction. Please try again!"
	      gon.client_token = generate_client_token
	      render :new
	    end
	end

	# def create
	# 	@transaction = Transaction.new(transaction_params)
	# 	if @transaction.save
	# 		render json: @transaction
	# 	else
	# 		render json: { error: @transaction.errors.full_messages }
	# 	end
	# end

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
	 
	def generate_client_token
	  Braintree::ClientToken.generate
	end

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