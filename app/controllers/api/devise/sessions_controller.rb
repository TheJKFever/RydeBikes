class Api::Devise::SessionsController < Devise::SessionsController
  include ApiAuthentication
  skip_before_filter :verify_authenticity_token
  before_filter :authenticate_apiKey, except: [:new, :create]

  # before_filter :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    resource = warden.authenticate!(auth_options)
    resource.generate_new_api_key
    resource.save
    yield resource if block_given?
    if resource.persisted?
      sign_in(resource)
      render :json => resource.asj_json({:include => :api_key}), :status => :ok, location: after_sign_in_path_for(resource)
    else
      clean_up_passwords resource
      render :json => {:error => resource.errors.message}, :status => :internal_server_error
  end

  # protected

  # You can put the params you want to permit in the empty array.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :attribute
  #   devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :password_confirmation, :firstname, :middlename, :lastname, :nickname) }
  #   devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:email, :password, :password_confirmation, :current_password, :firstname, :middlename, :lastname, :nickname) }
  # end
end
