require 'populator'
require 'faker'
namespace :db do
  desc "Erase, setup, and initialize development database"
  task :populate => :environment do
    # erase database
    Rake::Task['db:drop'].invoke if Rails.env != 'production'
    Rake::Task['db:migrate'].invoke
    Rake::Task['db:seed'].invoke

    # populate fake data
    BIKES = 20
    RIDES = 20
    USERS = 20
    password = 'password' # password for all users
    # encrypted_password = 'password'.salt

    # create bikes
    Bike.populate BIKES do |bike|
      bike.status = [Bike::STATUS[:reserved], Bike::STATUS[:available]]
      bike.location_id = 1..Coordinate.count
      bike.model = 'alpha'
      bike.network_id = 1..Network.count
      if (bike.status === Bike::STATUS[:reserved])
        bike.ride_id = 1..RIDES
      end
    end

    # create rides
    Ride.populate RIDES do |ride|
      ride.bike_id = 1..BIKES
      ride.user_id = 1..USERS
      ride.start_location_id = 1..Coordinate.count
      ride.start_time = 4.days.ago..1.minute.ago
      ride.status = [Ride::STATUS[:progress], Ride::STATUS[:complete]]
      if (ride.status === Ride::STATUS[:complete])
        ride.stop_location_id = 1..Coordinate.count
        ride.stop_time = Time.now
      end
    end

    # Change to populate
    # create users
    # TODO: this doesn't work because of encrypted_password, and confirm! and save validate false...
    # User.populate USERS do |user|
    #   user.name = Faker::Name.name
    #   user.phone = Faker::PhoneNumber.phone_number
    #   user.address_id = 1 # just give them all the same address for now
    #   # user.service_type = [ [User.service_type[:membership], User.service_type[:payperuse]].sample ]
    #   user.email = [user.name.delete(' ').downcase, Network.all.sample[:domain]].join('@') + '.edu'
    #   user.encrypted_password = encrypted_password
    #   user.network_id = 1..Network.count
    #   user.admin = false
    #   # user.confirm!
    #   # user.save(validate: false)
    # end
      
    USERS.times do
      user = User.new
      user.username = Faker::Internet.user_name
      user.name = Faker::Name.name
      user.phone = Faker::PhoneNumber.phone_number
      user.address_id = 1 # just give them all the same address for now
      # user.service_type = [ [User.service_type[:membership], User.service_type[:payperuse]].sample ]
      user.email = [user.name.delete(' ').downcase, Network.all.sample[:domain]].join('@') + '.edu'
      user.password = password
      user.network_id = (1..Network.count).to_a.sample
      user.admin = false
      user.status = User::STATUS.values.sample
      # user.confirm!
      user.save(validate: false)
    end

    # create an admin user
    user = User.new
    user.username = Faker::Internet.user_name
    user.name = 'admin'
    user.phone = Faker::PhoneNumber.phone_number
    user.address_id = 1 # just give them all the same address
    # user.service_type = User.service_type[:compt],
    user.email = 'rydebikes@usc.edu'
    user.password = password
    user.network_id = 1
    user.admin = true
    # user.confirm!
    user.save(validate: false)
  end
end
