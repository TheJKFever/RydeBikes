namespace :db do
	desc "Erase and fill database"
	task :populate => :environment do
		require 'populator'
		# erase database
		# populate sample data

	end
end