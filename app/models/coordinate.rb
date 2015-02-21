class Coordinate < ActiveRecord::Base
	# Change these to has_many's and somehow limit the locations...

	# validates :name, presence: true

	has_one :ride, foreign_key: "start_location"
	has_one :ride, foreign_key: "stop_location"
	has_one :bike, foreign_key: "location_id"
	has_one :interest

# TODO: put method in here for geolocation
	after_validation :geocode          # auto-fetch coordinates
	geocoded_by :full_address

	# reverse_geocoded_by :latitude, :longitude
	# after_validation :reverse_geocode, address: :full_address  # auto-fetch address

	def as_json(options={})
		super(:only => [:name, :full_address])
	end
end
