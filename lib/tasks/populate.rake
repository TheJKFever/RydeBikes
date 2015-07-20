require 'populator'
require 'faker'
namespace :db do
  desc "Erase, setup, and initialize development database"
  task :populate => :environment do
    # erase database
    Rake::Task['db:drop'].invoke if Rails.env != 'production'
    Rake::Task['db:migrate'].invoke
    Rake::Task['db:seed'].invoke

    def get_random(klass)
      offset = rand(klass.count)
      klass.offset(offset).first
    end

    def build_bike
      bike = Bike.new
      bike.status = Bike.statuses.values.sample
      bike.location = get_random(Coordinate)
      bike.model = 'alpha'
      bike.network = get_random(Network)
      if bike.reserved?
        bike.current_ride = build_ride(bike)
      end
      return bike
    end

    def build_ride(bike = nil)
      ride = Ride.new
      ride.bike = bike.nil? ? get_random(Bike) : bike
      ride.user = User.all.sample
      ride.start_location = get_random(Coordinate)
      ride.start_time = rand(4.days.ago..1.minute.ago)
      ride.status = Ride.statuses.values.sample
      if ride.complete?
        ride.stop_location = get_random(Coordinate)
        ride.stop_time = Time.now
      end
      return ride
    end

    # populate fake data
    BIKES = 20
    RIDES = 20
    USERS = 20
    password = 'password' # password for all users
    # encrypted_password = 'password'.salt

    USERS.times do |n|
      user = User.new
      user.username = "#{Faker::Internet.user_name}#{n}"
      user.name = Faker::Name.name
      user.phone = Faker::PhoneNumber.phone_number
      user.address_id = 1 # just give them all the same address for now
      # user.service_type = [ [User.service_type[:membership], User.service_type[:payperuse]].sample ]
      user.email = [user.name.delete(' ').downcase, Network.all.sample[:domain]].join('@') + '.edu'
      user.password = password
      user.network = get_random(Network)
      user.admin = false
      user.status = User::STATUS.values.sample
      user.save!
    end

    # create an admin user
    user = User.new
    user.username = 'admin'
    user.name = 'admin'
    user.phone = Faker::PhoneNumber.phone_number
    user.address_id = 1 # just give them all the same address
    # user.service_type = User.service_type[:compt],
    user.email = 'rydebikes@usc.edu'
    user.password = password
    user.network_id = 1
    user.admin = true
    user.status = User::STATUS[:goodstanding]
    user.save!

    # create bikes
    BIKES.times do
      bike = build_bike
      bike.save!
    end

    # create rides
    RIDES.times do
      ride = build_ride
      ride.save!
    end
  end
end
