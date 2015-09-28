class HelpMailer < ApplicationMailer
  default from: 'donotreply@rydebikes.com'
 
  def help_email(category, subcategory, message, user)
    @category = category
    @subcategory = subcategory
    @message = message
    @user = user
    mail(to: "info@rydebikes.com", subject: "Help request from Ryde user: #{user.username}")
  end  

end
