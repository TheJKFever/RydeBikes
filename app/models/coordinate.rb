class Coordinate < ActiveRecord::Base
	# Change these to has_many's and somehow limit the locations...

	# validates :name, presence: true

	belongs_to :network
	has_one :ride, foreign_key: "start_location_id"
	has_one :ride, foreign_key: "stop_location_id"
	has_one :bike, foreign_key: "location_id"
	has_one :interest

	# after_validation :geocode          # auto-fetch coordinates
	# geocoded_by :full_address

	# reverse_geocoded_by :latitude, :longitude
	# after_validation :reverse_geocode, address: :full_address  # auto-fetch address

	# def serializable_hash(options={})
	# 	super(:only => [:name, :full_address])
	# end
end