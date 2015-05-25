class Api::Devise::SessionsController < Devise::SessionsController
  include ApiAuthentication
  skip_before_filter :verify_authenticity_token
  before_filter :authenticate_apiKey, except: [:new, :create]

  respond_to :json
  # before_filter :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    @user = warden.authenticate!(auth_options)
    sign_in(@user)
    yield @user if block_given?
    render json: @user.as_json({:include => :api_key})
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # You can put the params you want to permit in the empty array.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :attribute
  # end
end
