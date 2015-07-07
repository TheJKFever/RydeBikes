# NOT USING THIS CLASS ANYMORE BUT COMMENTED OUT FOR CODE ABOUT DEFAULTS
# # represents Braintree customer
# # - token is used for customer_id
# # Braintree stores the actual payment methods, authorizations, and defaults
# # too access the customers information on braintree use:
# # SERVER SIDE: 
# #   customer = Braintree::Customer.find(token)
# # CLIENT SIDE:
# #   render Braintree::ClientToken.generate(:customer_id => token)
# #   then use client sdk to communicate with Braintree
# class Payment < ActiveRecord::Base
#   STATUS = {
#     :expired => "card expired",
#     :valid => "valid payment method",
#     :invalid => "invalid payment method"
#   }

#   belongs_to :user
#   has_many :trans, class_name: "Transaction"

#   validates_presence_of :user, :token, :status
#   # validate :has_a_default?
#   # after_save :remove_old_defaults, if: :has_multiple_defaults?

#   private

#   # def has_a_default?
#   # return true if default
#   #   @payments = Payment.where(user_id: user_id)
#   #   if @payments.count === 0
#   #     self.default = true
#   #     return true
#   #   end
#   #   return true if @payments.where(default: true).count > 0
#   #   errors.add(:default, "Must have a default payment method")
#   # end

#   # def has_multiple_defaults?
#   #   return true if Payment.where(user_id: user_id, default: true).count > 1
#   #   return false
#   # end

#   # def remove_old_defaults # ensures only one default
#   #   @payment = Payment.where(user_id: user_id, default: true).where.not(id: self.id).first
#   #   @payment.default = false
#   #   @payment.save(validate: false)
#   # end
# end
