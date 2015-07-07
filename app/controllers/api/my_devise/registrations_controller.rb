# class Api::Devise::RegistrationsController < Devise::RegistrationsController
#   skip_before_action :authenticate_apiKey, only: [:new, :create]
#   # before_action :configure_sign_up_params, only: [:create]
#   # before_action :configure_account_update_params, only: [:update]

#   # GET /resource/sign_up
#   def new
#     super
#   end

#   # POST /resource
#   # sign up, creates a new user
#   def create
#     resource = build_resource(sign_up_params)
#     resource.generate_new_api_key
#     resource.save
#     yield resource if block_given?
#     if resource.persisted?
#       sign_up(resource_name, resource)
#       render json: resource.as_json, status: :ok, location: after_sign_up_path_for(resource)
#     else
#       clean_up_passwords resource
#       set_minimum_password_length
#       render json: { error: resource.errors.message }, status: :internal_server_error
#     end
#   end

#   # GET /resource/edit
#   # def edit
#   #   super
#   # end

#   # PUT /resource
#   # def update
#   #   super
#   # end

#   # DELETE /resource
#   # def destroy
#   #   super
#   # end

#   # GET /resource/cancel
#   # Forces the session data which is usually expired after sign
#   # in to be expired now. This is useful if the user wants to
#   # cancel oauth signing in/up in the middle of the process,
#   # removing all OAuth session data.
#   # def cancel
#   #   super
#   # end

#   protected

#   # You can put the params you want to permit in the empty array.
#   # def configure_sign_up_params
#   #   devise_parameter_sanitizer.for(:sign_up) << :attribute
#   # end

#   # You can put the params you want to permit in the empty array.
#   # def configure_account_update_params
#   #   devise_parameter_sanitizer.for(:account_update) << :attribute
#   # end

#   # The path used after sign up.
#   # def after_sign_up_path_for(resource)
#   #   super(resource)
#   # end

#   # The path used after sign up for inactive accounts.
#   # def after_inactive_sign_up_path_for(resource)
#   #   super(resource)
#   # end

#   # Sets minimum password length to show to user
#   def set_minimum_password_length
#     if devise_mapping.validatable?
#       @minimum_password_length = resource_class.password_length.min
#     end
#   end
# end
