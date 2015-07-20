# Controller that interfaces with Braintree Customer Objects
class Api::PaymentsController < Api::ApiController

  ## BRAINTREE WORKFLOW ##
  # see https://developers.braintreepayments.com/ios+ruby/guides/drop-in
  # How to create a customer object, and get a payment method
  # 1. client requests a blank token by calling get /account/payments/new
  # 2. client uses token to collect customer info and payment_method_nonce
  # 3. client sends info and nonce to post /account/payments
  #    If the post is successful, a customer object should be created on 
  #    Braintree and the customer_id will be saved in user.braintree_id. 
  #    This id can be used to retreive information about the customer,
  #    including payment_methods, which includes a payment_method_token.
  #    A transaction can be made with either a payment_method nonce or token.
  # 4a. The server can now create a transaction with a payment_method_token
  # 4b. The client can update client information with a client_token by 
  #     calling get /api/account/payments/client_token

  def new
    render json: { braintree: Braintree::ClientToken.generate } 
  end

  def list # get a list of all customers payment methods (credit cards)
    customer = @user.get_braintree_customer
    return customer.payment_methods
  end

  def create
    result = Braintree::Customer.create(payment_params)
    if result.success?
      @user.braintree_id = result.customer.id
      render json: { error: @user.errors } unless @user.save
      render json: { success: 'Payment method successfully added'}
    else
      render json: { error: result.errors }, status: :unprocessable_entity
    end    
  end

  def client_token
    validates_payment_and_good_standing
    client_token = Braintree::ClientToken.generate(
      :customer_id => @user.braintree_id
    )
    render json: { braintree_client_token: client_token }, status: :ok
  rescue User::NoPaymentMethodException => exception
    return render json: { error: @user.errors }, 
      status: :payment_required, 
      location: api_new_payment_path
  rescue User::OutStandingBalanceException => exception
    return render json: { error: @user.errors }, 
      status: :forbidden, 
      location: api_collections_path
  end

  private

  def payment_params
    params.require(:payment).permit(:first_name, :last_name, :company, :email, :phone, :fax, :website, :payment_method_nonce)
  end
end