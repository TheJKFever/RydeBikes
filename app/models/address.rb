class Address < ActiveRecord::Base
	has_many :users

	# TODO: validates :is_real_address
end
