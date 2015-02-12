class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
  	if (current_user.valid_email)
      # user signed in, but not necesarilly validated
  		redirect_to CONFIRM_EMAIL_PATH if !(current_user.confirmed?)
  		redirect_to home_path
  	else
  		redirect_to INVALID_EMAIL_PATH if (!current_user.valid_email)
  		redirect_to CREATE_PASSWORD_PATH if (!current_user.valid_password)
  		# not sure what other errors there would be, so just sign out
  		sign_out(current_user)
  	end
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path # login page
  end
end
