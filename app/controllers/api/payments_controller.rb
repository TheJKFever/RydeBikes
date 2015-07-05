class Api::PaymentsController < Api::ApiController
  # before_action :set_payment, only: [:show, :edit, :update, :destroy]

  respond_to :json

  def new
    render json: { braintree: Braintree::ClientToken.generate } 
  end

  def create
    result = Braintree::Customer.create(payment_params)
    if result.success?
      @user.braintree_token = result.customer.id
      if @user.save
        render json: { success: 'Payment method successfully added'}
      else
        render json: { error: @user.errors }
      end
    else
      render json: { error: result.errors }, status: :unprocessable_entity
    end    
  end

  def client_token
    validates_has_payment_and_good_standing
    Braintree::ClientToken.generate(
      :customer_id => @user.braintree_token
    )
  end

  private

  def payment_params
    params.require(:payment).permit(:first_name, :last_name, :company, :email, :phone, :fax, :website, :payment_method_nonce)
  end
   
  def set_payment
    @payment = Transaction.find(params[:id])
    redirect_to home_path if (current_user != @payment.user || current_user.admin?)
  end
end