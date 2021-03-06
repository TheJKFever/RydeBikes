class Transaction < ActiveRecord::Base

	enum methods: [:pay_per_use, :prepay, :subscription]

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
			payment_id: (User.get_default_payment_method(user)).token
		)

		# Do Transaction Here

		@transaction.payment_type = response.payment_instrument_type
		@transaction.status = response.status
		@transaction.details = response
		@transaction.save!
	end

	class Rejected < Exception
	end

end