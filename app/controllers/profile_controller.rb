class ProfileController < ApplicationController
  skip_before_action :validate_login_process, only: [:edit, :edit_basic] 

end
