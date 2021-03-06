# class Api::Devise::SessionsController < Api::DeviseController
#   skip_before_action :authenticate_apiKey, only: [:new, :create]
#   skip_before_action :validate_login_process, only: [:new, :create]

#   # GET /sign_in
#   def new
#     super
#   end

#   # POST /sign_in
#   def create
#     resource = warden.authenticate!(auth_options)
#     resource.save
#     yield resource if block_given?
#     if resource.persisted?
#       resource.generate_new_api_key
#       sign_in(resource)
#       render json: resource.as_json, status: :ok, location: after_sign_in_path_for(resource)
#     else
#       clean_up_passwords resource
#       render json: { error: resource.errors.message }, status: :internal_server_error
#     end
#   end

#   private

#   def auth_options
#     { scope: resource_name, recall: "#{controller_path}#new" }
#   end

#   # You can put the params you want to permit in the empty array.
#   # def configure_sign_in_params
#   #   devise_parameter_sanitizer.for(:sign_in) << :attribute
#   #   devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :password_confirmation, :firstname, :middlename, :lastname, :nickname) }
#   #   devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:email, :password, :password_confirmation, :current_password, :firstname, :middlename, :lastname, :nickname) }
#   # end
# end
