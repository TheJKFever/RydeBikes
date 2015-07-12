class Transaction < ActiveRecord::Base
	METHODS = {
		:subscription => "subscription",
		:prepay => "prepay",
		:pay_per_use => "pay_per_use"
	}
	
	belongs_to :payment
	belongs_to :user
	belongs_to :ride

	serialize :details

	validates_presence_of :ride, :user

	# Must have ride_id and user_id set
	def charge_user_for_ride(user, ride)
		@transaction = new(
			user: user, 
			ride: ride, 
			amount: ride.calculate_cost,
			payment_id: (User.get_default_payment_method).token
		)

		@transaction.payment_type = response.payment_instrument_type
		@transaction.status = response.status
		@transaction.details = response

	end

	class Rejected < Exception
	end

end