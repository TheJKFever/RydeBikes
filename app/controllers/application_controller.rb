class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # Consider making this into one because one doesn't work without the other
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :validate_login_process, unless: :devise_controller?

  respond_to :json, :html

  def after_sign_in_path_for(resource)
    home_path
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path # login page
  end

  def authenticate_admin!
    if !current_user || !current_user.admin?
      respond_to do |format|
        format.html redirect_to root_path, :alert => 'Must have administrative priviledges'
        format.json render json: { error: 'Must have administrative priviledges' }, status: :unauthorized, location: root_path
      end
    end
  end

  # ensures:
  #  user has provided required basic info
  #  not first_time login
  def validate_login_process
    path, error = validate_login_process_for(current_user)
    if (error)
      respond_to do |format|
        format.html redirect_to path, :alert => error
        format.json render json: { error: error }, status: :unauthorized,  location: path
      end
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :username
    devise_parameter_sanitizer.for(:account_update) << :username
    devise_parameter_sanitizer.for(:sign_in).push(:username, :login)
  end

  # returns path, error
  def validate_login_process_for(user)
    return edit_basic_profile_path(user), "Please provide the requied profile information" if !user.has_basic_profile_info?
    return first_login_path, "Please complete the first login tutorial" if first_time_login == true
    return home_path, nil
  end
end

# Sign up / facebook
# get profile information
#   what's required?
# get payment method
# first_time_user intro (set flag)

# request bike for first time


# payment_method_in_good_standing
# payout_method_in_good_standing