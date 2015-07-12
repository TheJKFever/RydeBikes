# All Api controllers should inherit from this class
class Api::ApiController < ApplicationController
  # remove session handling, allowing CSRF for API
  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token
  # requires Api key to move forward
  skip_before_action :authenticate_user!
  # opens Api to all requests
  before_action :set_headers_for_api
  before_action :authenticate_apiKey
  before_action :validate_login_process

  # TODO: remove flash, assets, cookies, etc

  respond_to :json
  # skip rendering layouts
  layout nil  

  def after_sign_in_path_for(api_resources)
    '/api' + super
  end

  def validate_login_process
    # temporarily returning true until futhur notice
    return true
    path, error = validate_login_process_for(@user)
    render json: { error: error }, status: :unauthorized,  location: '/api' +path if error.present?
  end

  protected

  ## DANGER PLEASE READ
  # set_headers_for_api makes this API publicly available to anyone on the internet
  # Use caution to ensure every request is authenticated and does not respond with unathorized information
  # Prevents checking of 'Cross-origin Resource Sharing (CORS)'
  def set_headers_for_api
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Expose-Headers'] = 'ETag'
    headers['Access-Control-Allow-Methods'] = 'GET, POST, PATCH, PUT, DELETE, OPTIONS, HEAD'
    headers['Access-Control-Allow-Headers'] = '*,x-requested-with,Content-Type,If-Modified-Since,If-None-Match'
    headers['Access-Control-Max-Age'] = '86400'
  end

  # X-Api-Key is sent in header and
  # @user exists with that key
  def authenticate_apiKey
    unless request.headers['X-Api-Key'].present? && @user = User.find_by_access_token(request.headers['X-Api-Key'])
      # fail!
      return render :json => { :error => "Please provide a valid API Key" }, :status => :unauthorized, :location => new_user_session_path 
    end
  end
end