class Api::Devise::RegistrationsController < Api::ApiController
  skip_before_action :authenticate_apiKey, only: [:create]
  skip_before_action :validate_login_process, only: [:create]

  # POST /api/sign_up
  def create
    user = User.new(sign_up_params)
    user.save
    byebug
    if user.persisted?
      # if user.active_for_authentication?
        user.generate_new_api_key
        sign_in(user)
        render json: user, location: after_sign_up_path_for(user)
      # else
      #   expire_data_after_sign_in!
      #   message = find_message("signed_up_but_#{user.inactive_message}")
      #   render json: { error: message, user: resource }, location: after_inactive_sign_up_path_for(resource)
      # end
    else
      user.password = nil
      render json: { error: user.errors }, status: :unprocessable_entity
    end
  end

  # PUT /api/profile
  def update
    # self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    # prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)
    if @user.update_attribute(account_update_params)
      # kind = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
      #   :update_needs_confirmation : :updated
      # message = find_message(kind)
      sign_in @user, bypass: true
      render json: { user: @user }, location: after_update_path_for(@user)
    else
      @user.password = nil
      render json: { error: @user.errors }, status: :unprocessable_entity
    end
  end

  protected

  # def update_needs_confirmation?(resource, previous)
  #   resource.respond_to?(:pending_reconfirmation?) &&
  #     resource.pending_reconfirmation? &&
  #     previous != resource.unconfirmed_email
  # end

  # By default we want to require a password checks on update.
  # You can overwrite this method in your own RegistrationsController.
  # def update_resource(resource, params)
  #   resource.update_with_password(params)
  # end

  # Build a devise resource passing in the session. Useful to move
  # temporary session data to the newly created user.
  # def build_resource(hash=nil)
  #   self.resource = resource_class.new_with_session(hash || {}, session)
  # end

  # Signs in a user on sign up. You can overwrite this method in your own
  # RegistrationsController.
  # def sign_up(resource_name, resource)
  #   sign_in(resource_name, resource)
  # end

  # The path used after sign up. You need to overwrite this method
  # in your own RegistrationsController.
  def after_sign_up_path_for(resource)
    # TODO: change this for get_basic_user_info
    after_sign_in_path_for(resource)
  end

  # The path used after sign up for inactive accounts. You need to overwrite
  # this method in your own RegistrationsController.
  # def after_inactive_sign_up_path_for(resource)
  #   scope = Devise::Mapping.find_scope!(resource)
  #   router_name = Devise.mappings[scope].router_name
  #   context = router_name ? send(router_name) : self
  #   context.respond_to?(:root_path) ? context.root_path : "/"
  # end

  # The default url to be used after updating a resource.
  def after_update_path_for(resource)
    signed_in_root_path(resource)
  end

  def sign_up_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
