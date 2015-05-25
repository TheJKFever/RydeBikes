class Network < ActiveRecord::Base
	has_many :locations, class_name: 'Coordinate', foreign_key: 'network_id'
	has_many :users
	has_many :bikes
end
