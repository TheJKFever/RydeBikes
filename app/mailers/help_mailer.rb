class HelpMailer < ApplicationMailer
  default from: 'donotreply@rydebikes.com'
 
  def help_email(category, subcategory, message, user)
    @category = category
    @subcategory = subcategory
    @message = message
    @user = user
    email = "info@rydebikes.com"
    subject = "Help request from Ryde user: #{user.username}"
    mail(to: email, subject: subject)
    Rails.logger.info "Sent help_email email to #{email}"
  end  

end
