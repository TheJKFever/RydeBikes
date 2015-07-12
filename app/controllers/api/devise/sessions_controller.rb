require 'warden'
require 'devise'
class Api::Devise::SessionsController < Api::ApiController
  skip_before_action :authenticate_apiKey, only: [:new, :create]
  skip_before_action :validate_login_process, only: [:new, :create]
  before_action :allow_params_authentication!

  # POST /api/sign_in
  def create
  #   self.resource = warden.authenticate!(auth_options)
  #   self.resource.generate_new_api_key
  #   sign_in(resource_name, resource)
  #   render json: resource, location: after_sign_in_path_for(resource)
    user = warden.authenticate!(auth_options)
    user.generate_new_api_key
    sign_in(user)
    render json: user, location: after_sign_in_path_for(user)
  end

  protected

  def auth_options
    {:scope => :user}
  end

  def translation_scope
    'devise.sessions'
  end
end
