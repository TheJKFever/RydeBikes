class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  respond_to :json, :html

  def after_sign_in_path_for(resource)
  	if (current_user.valid_email)
      # user signed in, but not necesarilly validated
  		return CONFIRM_EMAIL_PATH if !(current_user.confirmed?)
  		return home_path
  	else
  		return INVALID_EMAIL_PATH if (!current_user.valid_email)
  		return CREATE_PASSWORD_PATH if (!current_user.valid_password)
  		# not sure what other errors there would be, so just sign out
  		sign_out(current_user)
  	end
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path # login page
  end

  def authenticate_admin!
    if !current_user || !current_user.admin?
      respond_to do |format|
        format.html redirect_to root_path, flash[:alert] = 'Must have administrative priviledges'
        format.json { render { error: 'Must have administrative priviledges' }
      end
    end
    # return render json: { error: 'Must have administrative priviledges' } if (!current_user || !current_user.admin?)
  end
end
