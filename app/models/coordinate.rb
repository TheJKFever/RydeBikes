class Coordinate < ActiveRecord::Base
	has_one :ride, foreign_key: "start_location"
	has_one :ride, foreign_key: "stop_location"
	has_one :bike, foreign_key: "location"

# TODO: put method in here for geolocation
end
