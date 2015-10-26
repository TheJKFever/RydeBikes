class ApplicationMailer < ActionMailer::Base
  default from: "server@rydebikes.com"
  layout 'mailer'

  def bikes_been_reserved_for(minutes, user, bike_id) # email to admin
    # user has rented bike_id for minutes
    @user = user
    @bike_id = bike_id
    @minutes = minutes
    email = "info@rydebikes.com"
    subject = "Bike #{bike_id} reserved for over #{minutes}: #{user.username}"
    mail(to: email, subject: subject)
    Rails.logger.info "Sent bikes_been_reserved_for #{minutes} minutes email to #{email} for bike #{bike_id}"
  end

end