namespace :db do
	desc "Erase and fill database"
	task :populate => :environment do
		require 'populator'
		require 'faker'
		# erase database
		Rake::Task['db:reset'].invoke

		# populate fake data
		BIKES = 20
		RIDES = 20
		USERS = 20
		password = 'password' # password for all users

		# create bikes
		Bike.populate BIKES do |bike|
			bike.status = [Bike.status[:reserved], Bike.status[:available]]
			bike.location_id = 1..Coordinate.count
			bike.model = 'alpha'
			bike.network_id = 1..Network.count
			if (bike.status===Bike.status[:reserved])
				bike.ride_id = 1..RIDES
			end
		end

		# create rides
		Ride.populate RIDES do |ride|
			ride.bike_id = 1..BIKES
			ride.user_id = 1..USERS
			ride.start_location_id = 1..Coordinate.count
			ride.start_time = 4.days.ago..1.minute.ago
			ride.status = [Ride.status[:progress], Ride.status[:complete]]
			if (ride.status === Ride.status[:cÏomplete])
				ride.stop_location_id = 1..Coordinate.count
				ride.stop_time = Time.now
			end
		end

		# TODO: create multiple addresses later, change 1 to 1..
		# create an address for users
		Address.create({
		    street: Faker::Address.street_address,
		    apt: '',
		    city: 'Los Angeles',
		    zipcode: '90007',
		    state: 'CA'
		})

		# create users
		USERS.times do
			@user = User.new
			@user.name = Faker::Name.name
			@user.phone = Faker::PhoneNumber.phone_number
			@user.address_id = 1 # just give them all the same address for now
			@user.service_type = [ [User.service_type[:membership], User.service_type[:payperuse]].sample ]
			@user.email = Faker::Internet.email #[@user.name.delete(' ').downcase, Network.all.sample(1)[:domain]].join('@') + '.edu'
			@user.password = password
			@user.network_id = 1..Network.count
			@user.admin = false
			@user.confirm!
			@user.save(validate: false)
		end

		# create an admin user
		@user = User.new
		@user.name = 'admin',
		@user.phone = Faker::PhoneNumber.phone_number,
		@user.address_id = 1, # just give them all the same address
		@user.service_type = User.service_type[:compt],
		@user.email = 'rydebikes@usc.edu',
		@user.password = password,
		@user.network_id = 1,
		@user.admin = true
		@user.confirm!
		@user.save(validate: false)

	end
end
